import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livechat/turn.dart';
import 'package:livechat/websocket.dart';

import 'device_info.dart';
import 'random_string.dart';

enum SignalingState { connectionOpen, connectionClosed, connectionError }

enum CallState {
  callStateNew,
  callStateRinging,
  callStateInvite,
  callStateConnected,
  callStateBye,
}

enum VideoSource { camera, screen }

class Session {
  Session({required this.sid, required this.pid});

  String pid;
  String sid;
  RTCPeerConnection? pc;
  RTCDataChannel? dc;
  List<RTCIceCandidate> remoteCandidates = [];
}

abstract interface class SignalingStateListener {
  void onSignalingStateChange(SignalingState state) {}

  void onCallStateChange(Session session, CallState state) {}

  void onLocalStream(MediaStream stream) {}

  void onAddRemoteStream(Session session, MediaStream stream) {}

  void onRemoveRemoteStream(Session session, MediaStream stream) {}

  void onPeersUpdate(dynamic event) {}

  void onDataChannelMessage(
    Session session,
    RTCDataChannel dc,
    RTCDataChannelMessage data,
  ) {}

  void onDataChannel(Session session, RTCDataChannel dc) {}
}

class Signaling implements SignalingStateListener {
  Signaling(this._host, this._context);

  final JsonEncoder _encoder = JsonEncoder();
  final JsonDecoder _decoder = JsonDecoder();
  final String _selfId = randomNumeric(6);
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

  final List<SignalingStateListener> _listeners = [];

  void addListener(SignalingStateListener listener) {
    _listeners.add(listener);
  }

  void removeListener(SignalingStateListener listener) {
    _listeners.remove(listener);
  }

  Future<void> close() async {
    await _cleanSessions();
    _socket?.close();
  }

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
        onLocalStream(localStream);
    }
  }

  Future<void> switchToScreenSharing(MediaStream stream) async {
    final localStream = _localStream;
    if (localStream == null) return;

    switch (_videoSource) {
      case VideoSource.screen:
        break;
      default:
        _senders.where((sender) => sender.track?.kind == 'video').forEach((
          sender,
        ) async {
          await sender.replaceTrack(localStream.getVideoTracks()[0]);
        });

        onLocalStream(stream);
        _videoSource = VideoSource.screen;
    }
  }

  void muteMic() {
    final localStream = _localStream;
    if (localStream == null) return;

    bool enabled = localStream.getAudioTracks()[0].enabled;
    localStream.getAudioTracks()[0].enabled = !enabled;
  }

  Future<void> invite(String peerId, String media, bool useScreen) async {
    final sessionId = '$_selfId-$peerId';
    final session = await _createSession(
      null,
      peerId: peerId,
      sessionId: sessionId,
      media: media,
      screenSharing: useScreen,
    );

    _sessions[sessionId] = session;
    if (media == 'data') {
      await _createDataChannel(session);
    }

    await _createOffer(session, media);
    onCallStateChange(session, CallState.callStateNew);
    onCallStateChange(session, CallState.callStateInvite);
  }

  Future<void> bye(String sessionId) async {
    _send('bye', {'session_id': sessionId, 'from': _selfId});
    final session = _sessions[sessionId];
    if (session == null) return;

    await _closeSession(session);
  }

  Future<void> accept(String sessionId, String media) async {
    final session = _sessions[sessionId];
    if (session == null) return;

    await _createAnswer(session, media);
  }

  Future<void> reject(String sessionId) async {
    final session = _sessions[sessionId];
    if (session == null) return;

    await bye(session.sid);
  }

  Future<void> onMessage(Map<String, dynamic> message) async {
    final data = message['data'];
    final type = message['type'];

    switch (type) {
      case 'peers':
        Map<String, dynamic> event = <String, dynamic>{};
        event['self'] = _selfId;
        event['peers'] = data;
        onPeersUpdate(event);
      case 'offer':
        final peerId = data['from'];
        final description = data['description'];
        final media = data['media'];
        final sessionId = data['session_id'];
        final session = _sessions[sessionId];
        final newSession = await _createSession(
          session,
          peerId: peerId,
          sessionId: sessionId,
          media: media,
          screenSharing: false,
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

        onCallStateChange(newSession, CallState.callStateNew);
        onCallStateChange(newSession, CallState.callStateRinging);
      case 'answer':
        final description = data['description'];
        final sessionId = data['session_id'];
        final session = _sessions[sessionId];
        await session?.pc?.setRemoteDescription(
          RTCSessionDescription(description['sdp'], description['type']),
        );

        onCallStateChange(session!, CallState.callStateConnected);
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

        onCallStateChange(session, CallState.callStateBye);
        await _closeSession(session);
      case 'keepalive':
        print('keepalive response!');
      default:
        break;
    }
  }

  Future<void> connect() async {
    final url = 'https://$_host:$_port/ws';
    _socket = SimpleWebSocket(
      url,
      onOpen: () {
        print('onOpen');
        onSignalingStateChange(SignalingState.connectionOpen);
        _send('new', {
          'name': DeviceInfo.label,
          'id': _selfId,
          'user_agent': DeviceInfo.userAgent,
        });
      },
      onMessage: (message) {
        print('Received data: $message');
        onMessage(_decoder.convert(message));
      },
      onClose: (int? code, String? reason) {
        print('Closed by server [$code => $reason]!');
        onSignalingStateChange(SignalingState.connectionClosed);
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

  Future<MediaStream> createStream(
    String media,
    bool userScreen, {
    BuildContext? context,
  }) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': userScreen ? false : true,
      'video': userScreen
          ? true
          : {
              'mandatory': {
                'minWidth':
                    '640', // Provide your own width, height and frame rate here
                'minHeight': '480',
                'minFrameRate': '30',
              },
              'facingMode': 'user',
              'optional': [],
            },
    };
    late MediaStream stream;
    if (userScreen) {
      stream = await navigator.mediaDevices.getDisplayMedia(mediaConstraints);
    } else {
      stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    }

    onLocalStream(stream);
    return stream;
  }

  Future<Session> _createSession(
    Session? session, {
    required String peerId,
    required String sessionId,
    required String media,
    required bool screenSharing,
  }) async {
    final newSession = session ?? Session(sid: sessionId, pid: peerId);
    if (media != 'data') {
      _localStream = await createStream(
        media,
        screenSharing,
        context: _context,
      );
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
            onAddRemoteStream(newSession, stream);
            _remoteStreams.add(stream);
          };
          await pc.addStream(_localStream!);
          break;
        case 'unified-plan':
          // Unified-Plan
          pc.onTrack = (event) {
            if (event.track.kind == 'video') {
              onAddRemoteStream(newSession, event.streams[0]);
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
          'from': _selfId,
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
      onRemoveRemoteStream(newSession, stream);
      _remoteStreams.removeWhere((it) {
        return (it.id == stream.id);
      });
    };

    pc.onDataChannel = (channel) {
      _addDataChannel(newSession, channel);
    };

    newSession.pc = pc;
    return newSession;
  }

  void _addDataChannel(Session session, RTCDataChannel channel) {
    channel.onDataChannelState = (e) {};
    channel.onMessage = (RTCDataChannelMessage data) {
      onDataChannelMessage(session, channel, data);
    };

    session.dc = channel;
    onDataChannel(session, channel);
  }

  Future<void> _createDataChannel(
    Session session, {
    label = 'fileTransfer',
  }) async {
    RTCDataChannelInit dataChannelDict = RTCDataChannelInit()
      ..maxRetransmits = 30;
    RTCDataChannel channel = await session.pc!.createDataChannel(
      label,
      dataChannelDict,
    );

    _addDataChannel(session, channel);
  }

  Future<void> _createOffer(Session session, String media) async {
    try {
      RTCSessionDescription s = await session.pc!.createOffer(
        media == 'data' ? _dcConstraints : {},
      );
      await session.pc!.setLocalDescription(_fixSdp(s));
      _send('offer', {
        'to': session.pid,
        'from': _selfId,
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

  Future<void> _createAnswer(Session session, String media) async {
    try {
      RTCSessionDescription s = await session.pc!.createAnswer(
        media == 'data' ? _dcConstraints : {},
      );
      await session.pc!.setLocalDescription(_fixSdp(s));
      _send('answer', {
        'to': session.pid,
        'from': _selfId,
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
    onCallStateChange(sessionEntry.value, CallState.callStateBye);
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

  @override
  void onAddRemoteStream(Session session, MediaStream stream) {
    for (final listener in _listeners) {
      listener.onAddRemoteStream(session, stream);
    }
  }

  @override
  void onCallStateChange(Session session, CallState state) {
    for (final listener in _listeners) {
      listener.onCallStateChange(session, state);
    }
  }

  @override
  void onDataChannel(Session session, RTCDataChannel dc) {
    for (final listener in _listeners) {
      listener.onDataChannel(session, dc);
    }
  }

  @override
  void onDataChannelMessage(
    Session session,
    RTCDataChannel dc,
    RTCDataChannelMessage data,
  ) {
    for (final listener in _listeners) {
      listener.onDataChannelMessage(session, dc, data);
    }
  }

  @override
  void onLocalStream(MediaStream stream) {
    for (final listener in _listeners) {
      listener.onLocalStream(stream);
    }
  }

  @override
  void onPeersUpdate(event) {
    for (final listener in _listeners) {
      listener.onPeersUpdate(event);
    }
  }

  @override
  void onRemoveRemoteStream(Session session, MediaStream stream) {
    for (final listener in _listeners) {
      listener.onRemoveRemoteStream(session, stream);
    }
  }

  @override
  void onSignalingStateChange(SignalingState state) {
    for (final listener in _listeners) {
      listener.onSignalingStateChange(state);
    }
  }
}
