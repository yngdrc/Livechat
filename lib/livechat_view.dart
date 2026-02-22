import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livechat/screen_select_dialog.dart';
import 'package:livechat/signaling.dart';

class LivechatView extends StatefulWidget {
  const LivechatView({super.key, required this.host});

  final String host;

  @override
  State<StatefulWidget> createState() => _LivechatViewState();
}

class _LivechatViewState extends State<LivechatView>
    implements SignalingStateListener {
  Signaling? _signaling;
  List<dynamic> _peers = [];
  String? _selfId;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool _inCalling = false;
  Session? _session;
  DesktopCapturerSource? selectedSource;
  bool _waitAccept = false;

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _connect(context);
  }

  @override
  void deactivate() {
    super.deactivate();
    _signaling?.removeListener(this);
    _signaling?.close();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _connect(BuildContext context) async {
    _signaling ??= Signaling(widget.host, context)
      ..addListener(this)
      ..connect();
  }

  Future<bool?> _showAcceptDialog() {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("title"),
          content: Text("accept?"),
          actions: <Widget>[
            MaterialButton(
              child: Text('Reject', style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            MaterialButton(
              child: Text('Accept', style: TextStyle(color: Colors.green)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showInviteDialog() {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("title"),
          content: Text("waiting"),
          actions: <Widget>[
            TextButton(
              child: Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
                _hangUp();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> selectScreenSourceDialog(BuildContext context) async {
    MediaStream? screenStream;
    if (WebRTC.platformIsDesktop) {
      final source = await showDialog<DesktopCapturerSource>(
        context: context,
        builder: (context) => ScreenSelectDialog(),
      );
      if (source != null) {
        try {
          var stream = await navigator.mediaDevices.getDisplayMedia(
            <String, dynamic>{
              'video': {
                'deviceId': {'exact': source.id},
                'mandatory': {'frameRate': 30.0},
              },
            },
          );
          stream.getVideoTracks()[0].onEnded = () {
            print(
              'By adding a listener on onEnded you can: 1) catch stop video sharing on Web',
            );
          };
          screenStream = stream;
        } catch (e) {
          print(e);
        }
      }
    } else if (WebRTC.platformIsWeb) {
      screenStream = await navigator.mediaDevices.getDisplayMedia(
        <String, dynamic>{'audio': false, 'video': true},
      );
    }
    if (screenStream != null) _signaling?.switchToScreenSharing(screenStream);
  }

  void _invitePeer(BuildContext context, String peerId, bool useScreen) {
    if (_signaling != null && peerId != _selfId) {
      _signaling?.invite(peerId, 'video', useScreen);
    }
  }

  void _accept() {
    if (_session != null) {
      _signaling?.accept(_session!.sid, 'video');
    }
  }

  void _reject() {
    if (_session != null) {
      _signaling?.reject(_session!.sid);
    }
  }

  void _hangUp() {
    if (_session != null) {
      _signaling?.bye(_session!.sid);
    }
  }

  void _switchCamera() {
    _signaling?.switchCamera();
  }

  void _muteMic() {
    _signaling?.muteMic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'P2P Call Sample${_selfId != null ? ' [Your ID ($_selfId)] ' : ''}',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: null,
            tooltip: 'setup',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _inCalling
          ? SizedBox(
              width: 240.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    tooltip: 'Camera',
                    onPressed: _switchCamera,
                    child: const Icon(Icons.switch_camera),
                  ),
                  FloatingActionButton(
                    tooltip: 'Screen Sharing',
                    onPressed: () => selectScreenSourceDialog(context),
                    child: const Icon(Icons.desktop_mac),
                  ),
                  FloatingActionButton(
                    onPressed: _hangUp,
                    tooltip: 'Hangup',
                    backgroundColor: Colors.pink,
                    child: Icon(Icons.call_end),
                  ),
                  FloatingActionButton(
                    tooltip: 'Mute Mic',
                    onPressed: _muteMic,
                    child: const Icon(Icons.mic_off),
                  ),
                ],
              ),
            )
          : null,
      body: _inCalling
          ? OrientationBuilder(
              builder: (context, orientation) {
                return Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      top: 0.0,
                      bottom: 0.0,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(color: Colors.black54),
                        child: RTCVideoView(_remoteRenderer),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 20.0,
                      child: Container(
                        width: orientation == Orientation.portrait
                            ? 90.0
                            : 120.0,
                        height: orientation == Orientation.portrait
                            ? 120.0
                            : 90.0,
                        decoration: BoxDecoration(color: Colors.black54),
                        child: RTCVideoView(_localRenderer, mirror: true),
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              itemCount: (_peers.length),
              itemBuilder: (context, i) {
                return _buildRow(context, _peers[i]);
              },
            ),
    );
  }

  Widget _buildRow(context, peer) {
    var self = (peer['id'] == _selfId);
    return ListBody(
      children: <Widget>[
        ListTile(
          title: Text(
            self
                ? peer['name'] + ', ID: ${peer['id']} ' + ' [Your self]'
                : peer['name'] + ', ID: ${peer['id']} ',
          ),
          onTap: null,
          trailing: SizedBox(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    self ? Icons.close : Icons.videocam,
                    color: self ? Colors.grey : Colors.black,
                  ),
                  onPressed: () => _invitePeer(context, peer['id'], false),
                  tooltip: 'Video calling',
                ),
                IconButton(
                  icon: Icon(
                    self ? Icons.close : Icons.screen_share,
                    color: self ? Colors.grey : Colors.black,
                  ),
                  onPressed: () => _invitePeer(context, peer['id'], true),
                  tooltip: 'Screen sharing',
                ),
              ],
            ),
          ),
          subtitle: Text('[${peer['user_agent']}]'),
        ),
        Divider(),
      ],
    );
  }

  @override
  void onAddRemoteStream(Session session, MediaStream stream) {
    _remoteRenderer.srcObject = stream;
    setState(() {});
  }

  @override
  void onCallStateChange(Session session, CallState state) async {
    switch (state) {
      case CallState.callStateNew:
        setState(() {
          _session = session;
        });
        break;
      case CallState.callStateRinging:
        bool? accept = await _showAcceptDialog();
        if (accept!) {
          _accept();
          setState(() {
            _inCalling = true;
          });
        } else {
          _reject();
        }
        break;
      case CallState.callStateBye:
        if (_waitAccept) {
          print('peer reject');
          _waitAccept = false;
          Navigator.of(context).pop(false);
        }
        setState(() {
          _localRenderer.srcObject = null;
          _remoteRenderer.srcObject = null;
          _inCalling = false;
          _session = null;
        });
        break;
      case CallState.callStateInvite:
        _waitAccept = true;
        _showInviteDialog();
        break;
      case CallState.callStateConnected:
        if (_waitAccept) {
          _waitAccept = false;
          Navigator.of(context).pop(false);
        }
        setState(() {
          _inCalling = true;
        });

        break;
    }
  }

  @override
  void onDataChannel(Session session, RTCDataChannel dc) {
    // TODO: implement onDataChannel
  }

  @override
  void onDataChannelMessage(
    Session session,
    RTCDataChannel dc,
    RTCDataChannelMessage data,
  ) {
    // TODO: implement onDataChannelMessage
  }

  @override
  void onLocalStream(MediaStream stream) {
    _localRenderer.srcObject = stream;
    setState(() {});
  }

  @override
  void onPeersUpdate(event) {
    setState(() {
      _selfId = event['self'];
      _peers = event['peers'];
    });
  }

  @override
  void onRemoveRemoteStream(Session session, MediaStream stream) {
    _remoteRenderer.srcObject = null;
  }

  @override
  void onSignalingStateChange(SignalingState state) {
    switch (state) {
      case SignalingState.connectionClosed:
      case SignalingState.connectionError:
      case SignalingState.connectionOpen:
        break;
    }
  }
}
