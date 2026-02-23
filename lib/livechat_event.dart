part of 'livechat_bloc.dart';

@freezed
sealed class LivechatEvent with _$LivechatEvent {
  const factory LivechatEvent.initialize() = _Initialize;

  const factory LivechatEvent.callStateChange({
    required Session session,
    required CallState state,
  }) = _CallStateChange;

  const factory LivechatEvent.signalingStateChange({
    required SignalingState state,
  }) = _SignalingStateChange;

  const factory LivechatEvent.localMediaStreamChange({
    required MediaStream? stream,
  }) = _LocalMediaStreamChange;

  const factory LivechatEvent.remoteMediaStreamChange({
    required Session session,
    required MediaStream? stream,
  }) = _RemoteMediaStreamChange;

  const factory LivechatEvent.peersUpdate({
    required Map<String, dynamic> event,
  }) = _PeersUpdate;

  const factory LivechatEvent.showAcceptDialog() = ShowAcceptDialog;

  const factory LivechatEvent.showInviteDialog() = ShowInviteDialog;

  const factory LivechatEvent.accept() = _Accept;

  const factory LivechatEvent.reject() = _Reject;

  const factory LivechatEvent.hangUp() = _HangUp;

  const factory LivechatEvent.invitePeer({required String peerId}) =
      _InvitePeer;

  const factory LivechatEvent.toggleMicrophone() = _ToggleMicrophone;
  const factory LivechatEvent.switchCamera() = _SwitchCamera;
}
