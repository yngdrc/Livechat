import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livechat/session.dart';
import 'package:livechat/signaling_state.dart';

import 'call_state.dart';

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
