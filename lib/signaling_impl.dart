import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livechat/session.dart';
import 'package:livechat/signaling.dart';
import 'package:livechat/signaling_state.dart';
import 'package:livechat/turn.dart';
import 'package:livechat/video_source.dart';
import 'package:livechat/websocket.dart';

import 'call_state.dart';
import 'device_info.dart';

class SignalingImpl implements Signaling {
  SignalingImpl(this._host, this._context);

  final JsonEncoder _encoder = JsonEncoder();
  final JsonDecoder _decoder = JsonDecoder();
  SimpleWebSocket? _socket;
  final BuildContext? _context;
  final String _host;
  final int _port = 8086;
  Map<dynamic, dynamic>? _turnCredential;
  final Map<String, Session> _sessions = {};
  MediaStream? _localStream;
  final List<MediaStream> _remoteStreams = <MediaStream>[];
  final List<RTCRtpSender> _senders = <RTCRtpSender>[];
  VideoSource _videoSource = VideoSource.camera;

  String get sdpSemantics => 'unified-plan';

  Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      /*
       * turn server configuration example.
      {
        'url': 'turn:123.45.67.89:3478',
        'username': 'change_to_real_user',
        'credential': 'change_to_real_secret'
      },
      */
    ],
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  final Map<String, dynamic> _dcConstraints = {
    'mandatory': {'OfferToReceiveAudio': false, 'OfferToReceiveVideo': false},
    'optional': [],
  };

  final StreamController<(Session, CallState)> _callStateStreamController =
      StreamController.broadcast();

  final StreamController<SignalingState> _signalingStateStreamController =
      StreamController.broadcast();

  final StreamController<MediaStream?> _localMediaStreamController =
      StreamController.broadcast();

  final StreamController<(Session, MediaStream?)> _remoteMediaStreamController =
      StreamController.broadcast();

  final StreamController<Map<String, dynamic>> _peersUpdateStreamController =
      StreamController.broadcast();

  @override
  Stream<(Session, CallState)> get callStateStream =>
      _callStateStreamController.stream;

  @override
  Stream<SignalingState> get signalingStateStream =>
      _signalingStateStreamController.stream;

  @override
  Stream<MediaStream?> get localMediaStream =>
      _localMediaStreamController.stream;

  @override
  Stream<(Session, MediaStream?)> get remoteMediaStream =>
      _remoteMediaStreamController.stream;

  @override
  Stream<Map<String, dynamic>> get peersUpdateStream =>
      _peersUpdateStreamController.stream;

  @override
  Future<void> connect(String selfId) async {
    final url = 'https://$_host:$_port/ws';
    _socket = SimpleWebSocket(
      url,
      onOpen: () {
        print('onOpen');
        _signalingStateStreamController.add(SignalingState.connectionOpen);
        _send('new', {
          'name': DeviceInfo.label,
          'id': selfId,
          'user_agent': DeviceInfo.userAgent,
        });
      },
      onMessage: (message) {
        print('Received data: $message');
        _onMessage(selfId, _decoder.convert(message));
      },
      onClose: (int? code, String? reason) {
        print('Closed by server [$code => $reason]!');
        _signalingStateStreamController.add(SignalingState.connectionClosed);
      },
    );

    print('connect to $url');

    if (_turnCredential == null) {
      try {
        _turnCredential = await getTurnCredential(_host, _port);
        /*{
            "username": "1584195784:mbzrxpgjys",
            "password": "isyl6FF6nqMTB9/ig5MrMRUXqZg",
            "ttl": 86400,
            "uris": ["turn:127.0.0.1:19302?transport=udp"]
          }
        */
        _iceServers = {
          'iceServers': [
            {
              'urls': _turnCredential?['uris'][0],
              'username': _turnCredential?['username'],
              'credential': _turnCredential?['password'],
            },
          ],
        };
      } catch (e) {
        print(e);
      }
    }

    await _socket?.connect();
  }

  @override
  Future<void> close() async {
    await _cleanSessions();
    await _socket?.close();
    await _callStateStreamController.close();
  }

  @override
  Future<void> switchCamera() async {
    final localStream = _localStream;
    if (localStream == null) return;

    switch (_videoSource) {
      case VideoSource.camera:
        await Helper.switchCamera(localStream.getVideoTracks()[0]);
      default:
        _senders.where((sender) => sender.track?.kind == 'video').forEach((
          sender,
        ) async {
          await sender.replaceTrack(localStream.getVideoTracks()[0]);
        });

        _videoSource = VideoSource.camera;
        _localMediaStreamController.add(localStream);
    }
  }

  @override
  void toggleMicrophone() {
    final localStream = _localStream;
    if (localStream == null) return;

    bool enabled = localStream.getAudioTracks()[0].enabled;
    localStream.getAudioTracks()[0].enabled = !enabled;
  }

  @override
  Future<void> invite(String selfId, String peerId, String media) async {
    final sessionId = '$selfId-$peerId';
    final session = await _createSession(
      null,
      selfId: selfId,
      peerId: peerId,
      sessionId: sessionId,
      media: media,
    );

    _sessions[sessionId] = session;
    await _createOffer(selfId, session, media);
    _callStateStreamController.add((session, CallState.callStateNew));
    _callStateStreamController.add((session, CallState.callStateInvite));
  }

  @override
  Future<void> bye(String selfId, String sessionId) async {
    _send('bye', {'session_id': sessionId, 'from': selfId});
    final session = _sessions[sessionId];
    if (session == null) return;

    await _closeSession(session);
  }

  @override
  Future<void> accept(String selfId, String sessionId, String media) async {
    final session = _sessions[sessionId];
    if (session == null) return;

    await _createAnswer(selfId, session, media);
  }

  @override
  Future<void> reject(String selfId, String sessionId) async {
    final session = _sessions[sessionId];
    if (session == null) return;

    await bye(selfId, session.sid);
  }

  Future<void> _onMessage(String selfId, Map<String, dynamic> message) async {
    final data = message['data'];
    final type = message['type'];

    switch (type) {
      case 'peers':
        Map<String, dynamic> event = <String, dynamic>{};
        event['self'] = selfId;
        event['peers'] = data;
        _peersUpdateStreamController.add(event);
      case 'offer':
        final peerId = data['from'];
        final description = data['description'];
        final media = data['media'];
        final sessionId = data['session_id'];
        final session = _sessions[sessionId];
        final newSession = await _createSession(
          session,
          selfId: selfId,
          peerId: peerId,
          sessionId: sessionId,
          media: media,
        );

        _sessions[sessionId] = newSession;
        await newSession.pc?.setRemoteDescription(
          RTCSessionDescription(description['sdp'], description['type']),
        );
        // await _createAnswer(newSession, media);

        for (final candidate in newSession.remoteCandidates) {
          await newSession.pc?.addCandidate(candidate);
        }

        newSession.remoteCandidates.clear();

        _callStateStreamController.add((newSession, CallState.callStateNew));
        _callStateStreamController.add((
          newSession,
          CallState.callStateRinging,
        ));
      case 'answer':
        final description = data['description'];
        final sessionId = data['session_id'];
        final session = _sessions[sessionId];
        await session?.pc?.setRemoteDescription(
          RTCSessionDescription(description['sdp'], description['type']),
        );

        // TODO: handle null session
        _callStateStreamController.add((
          session!,
          CallState.callStateConnected,
        ));
      case 'candidate':
        final peerId = data['from'];
        final candidateMap = data['candidate'];
        final sessionId = data['session_id'];
        final session = _sessions[sessionId];
        RTCIceCandidate candidate = RTCIceCandidate(
          candidateMap['candidate'],
          candidateMap['sdpMid'],
          candidateMap['sdpMLineIndex'],
        );

        if (session == null) {
          _sessions[sessionId] = Session(pid: peerId, sid: sessionId)
            ..remoteCandidates.add(candidate);

          return;
        }

        if (session.pc == null) {
          return session.remoteCandidates.add(candidate);
        }

        await session.pc?.addCandidate(candidate);
      case 'leave':
        final peerId = data as String;
        await _closeSessionByPeerId(peerId);
      case 'bye':
        final sessionId = data['session_id'];
        print('$bye: $sessionId');
        final session = _sessions.remove(sessionId);
        if (session == null) return;

        _callStateStreamController.add((session, CallState.callStateBye));
        await _closeSession(session);
      case 'keepalive':
        print('keepalive response!');
      default:
        break;
    }
  }

  Future<MediaStream> _createStream(
    String media, {
    BuildContext? context,
  }) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': true,
    };

    final stream = await navigator.mediaDevices.getUserMedia(
      mediaConstraints,
    );

    _localMediaStreamController.add(stream);
    return stream;
  }

  Future<Session> _createSession(
    Session? session, {
    required String selfId,
    required String peerId,
    required String sessionId,
    required String media,
  }) async {
    final newSession = session ?? Session(sid: sessionId, pid: peerId);
    if (media != 'data') {
      _localStream = await _createStream(media, context: _context);
    }

    print(_iceServers);
    final pc = await createPeerConnection({
      ..._iceServers,
      ...{'sdpSemantics': sdpSemantics},
    }, _config);

    if (media != 'data') {
      switch (sdpSemantics) {
        case 'plan-b':
          pc.onAddStream = (MediaStream stream) {
            _remoteMediaStreamController.add((newSession, stream));
            _remoteStreams.add(stream);
          };
          await pc.addStream(_localStream!);
          break;
        case 'unified-plan':
          // Unified-Plan
          pc.onTrack = (event) {
            if (event.track.kind == 'video') {
              _remoteMediaStreamController.add((newSession, event.streams[0]));
            }
          };
          _localStream!.getTracks().forEach((track) async {
            _senders.add(await pc.addTrack(track, _localStream!));
          });
          break;
      }

      // Unified-Plan: Simuclast
      /*
      await pc.addTransceiver(
        track: _localStream.getAudioTracks()[0],
        init: RTCRtpTransceiverInit(
            direction: TransceiverDirection.SendOnly, streams: [_localStream]),
      );

      await pc.addTransceiver(
        track: _localStream.getVideoTracks()[0],
        init: RTCRtpTransceiverInit(
            direction: TransceiverDirection.SendOnly,
            streams: [
              _localStream
            ],
            sendEncodings: [
              RTCRtpEncoding(rid: 'f', active: true),
              RTCRtpEncoding(
                rid: 'h',
                active: true,
                scaleResolutionDownBy: 2.0,
                maxBitrate: 150000,
              ),
              RTCRtpEncoding(
                rid: 'q',
                active: true,
                scaleResolutionDownBy: 4.0,
                maxBitrate: 100000,
              ),
            ]),
      );*/
      /*
        var sender = pc.getSenders().find(s => s.track.kind == "video");
        var parameters = sender.getParameters();
        if(!parameters)
          parameters = {};
        parameters.encodings = [
          { rid: "h", active: true, maxBitrate: 900000 },
          { rid: "m", active: true, maxBitrate: 300000, scaleResolutionDownBy: 2 },
          { rid: "l", active: true, maxBitrate: 100000, scaleResolutionDownBy: 4 }
        ];
        sender.setParameters(parameters);
      */
    }

    pc.onIceCandidate = (candidate) async {
      await Future.delayed(
        const Duration(seconds: 1),
        () => _send('candidate', {
          'to': peerId,
          'from': selfId,
          'candidate': {
            'sdpMLineIndex': candidate.sdpMLineIndex,
            'sdpMid': candidate.sdpMid,
            'candidate': candidate.candidate,
          },
          'session_id': sessionId,
        }),
      );
    };

    pc.onIceConnectionState = (state) {};

    pc.onRemoveStream = (stream) {
      _remoteMediaStreamController.add((newSession, null));
      _remoteStreams.removeWhere((it) {
        return (it.id == stream.id);
      });
    };

    newSession.pc = pc;
    return newSession;
  }

  Future<void> _createOffer(
    String selfId,
    Session session,
    String media,
  ) async {
    try {
      RTCSessionDescription s = await session.pc!.createOffer(
        media == 'data' ? _dcConstraints : {},
      );
      await session.pc!.setLocalDescription(_fixSdp(s));
      _send('offer', {
        'to': session.pid,
        'from': selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': session.sid,
        'media': media,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  RTCSessionDescription _fixSdp(RTCSessionDescription s) {
    var sdp = s.sdp;
    s.sdp = sdp!.replaceAll(
      'profile-level-id=640c1f',
      'profile-level-id=42e032',
    );
    return s;
  }

  Future<void> _createAnswer(
    String selfId,
    Session session,
    String media,
  ) async {
    try {
      RTCSessionDescription s = await session.pc!.createAnswer(
        media == 'data' ? _dcConstraints : {},
      );
      await session.pc!.setLocalDescription(_fixSdp(s));
      _send('answer', {
        'to': session.pid,
        'from': selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': session.sid,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _send(event, data) {
    final request = {};
    request["type"] = event;
    request["data"] = data;
    _socket?.send(_encoder.convert(request));
  }

  Future<void> _cleanSessions() async {
    _localStream?.getTracks().forEach((element) async {
      await element.stop();
    });

    await _localStream?.dispose();
    _localStream = null;

    _sessions.forEach((key, sess) async {
      await sess.pc?.close();
      await sess.dc?.close();
    });

    _sessions.clear();
  }

  Future<void> _closeSessionByPeerId(String peerId) async {
    final sessionEntry = _sessions.entries.where((entry) {
      final ids = entry.key.split('-');
      return peerId == ids[0] || peerId == ids[1];
    }).firstOrNull;

    if (sessionEntry == null) return;

    _sessions.remove(sessionEntry.key);
    await _closeSession(sessionEntry.value);
    _callStateStreamController.add((
      sessionEntry.value,
      CallState.callStateBye,
    ));
  }

  Future<void> _closeSession(Session session) async {
    _localStream?.getTracks().forEach((element) async {
      await element.stop();
    });

    await _localStream?.dispose();
    _localStream = null;

    await session.pc?.close();
    await session.dc?.close();
    _senders.clear();
    _videoSource = VideoSource.camera;
  }
}
