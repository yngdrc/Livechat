part of 'livechat_bloc.dart';

@freezed
sealed class LivechatState with _$LivechatState {
  factory LivechatState.initial() => LivechatState(
    localRenderer: RTCVideoRenderer(),
    remoteRenderer: RTCVideoRenderer(),
    // TODO: use device id
    selfId: randomNumeric(6)
  );

  const factory LivechatState({
    required RTCVideoRenderer localRenderer,
    required RTCVideoRenderer remoteRenderer,
    required String selfId,
    @Default(false) bool inCalling,
    Session? session,
    @Default([]) List<dynamic> peers,
  }) = _LivechatState;
}
