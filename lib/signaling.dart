import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livechat/session.dart';
import 'package:livechat/signaling_state.dart';

import 'call_state.dart';

abstract interface class Signaling {
  Stream<(Session, CallState)> get callStateStream;

  Stream<SignalingState> get signalingStateStream;

  Stream<MediaStream?> get localMediaStream;

  Stream<(Session, MediaStream?)> get remoteMediaStream;

  Stream<Map<String, dynamic>> get peersUpdateStream;

  Future<void> connect(String selfId);

  Future<void> invite(String selfId, String peerId, String media);

  Future<void> accept(String selfId, String sessionId, String media);

  Future<void> reject(String selfId, String sessionId);

  Future<void> bye(String selfId, String sessionId);

  Future<void> switchCamera();

  void toggleMicrophone();

  Future<void> close();
}
