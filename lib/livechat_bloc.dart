import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:livechat/call_state.dart';
import 'package:livechat/random_string.dart';
import 'package:livechat/session.dart';
import 'package:livechat/signaling.dart';
import 'package:livechat/signaling_state.dart';

part 'livechat_bloc.freezed.dart';

part 'livechat_event.dart';

part 'livechat_state.dart';

class LivechatBloc extends Bloc<LivechatEvent, LivechatState>
    with BlocPresentationMixin<LivechatState, LivechatEvent> {
  LivechatBloc({required Signaling signaling})
    : _signaling = signaling,
      super(LivechatState.initial()) {
    signaling.callStateStream.listen((data) {
      final (session, state) = data;
      add(LivechatEvent.callStateChange(session: session, state: state));
    });

    signaling.signalingStateStream.listen((data) {
      add(LivechatEvent.signalingStateChange(state: data));
    });

    signaling.localMediaStream.listen((data) {
      add(LivechatEvent.localMediaStreamChange(stream: data));
    });

    signaling.remoteMediaStream.listen((data) {
      final (session, stream) = data;
      add(
        LivechatEvent.remoteMediaStreamChange(session: session, stream: stream),
      );
    });

    signaling.peersUpdateStream.listen((data) {
      add(LivechatEvent.peersUpdate(event: data));
    });

    on<_Initialize>(_onInitialize);
    on<_CallStateChange>(_onCallStateChange);
    on<_SignalingStateChange>(_onSignalingStateChange);
    on<_LocalMediaStreamChange>(_onLocalMediaStreamChange);
    on<_RemoteMediaStreamChange>(_onRemoteMediaStreamChange);
    on<_PeersUpdate>(_onPeersUpdate);

    on<_Accept>(_onAccept);
    on<_Reject>(_onReject);
    on<_HangUp>(_onHangUp);
    on<_InvitePeer>(_onInvitePeer);
    on<_ToggleMicrophone>(_onToggleMicrophone);
    on<_SwitchCamera>(_onSwitchCamera);
  }

  final Signaling _signaling;

  Future<void> _onInitialize(
    _Initialize event,
    Emitter<LivechatState> emit,
  ) async {
    await _initRenderers();
    await _signaling.connect(state.selfId);
  }

  Future<void> _onCallStateChange(
    _CallStateChange event,
    Emitter<LivechatState> emit,
  ) async {
    switch (event.state) {
      case CallState.callStateNew:
        emit(state.copyWith(session: event.session));
      case CallState.callStateRinging:
        emitPresentation(LivechatEvent.showAcceptDialog());
      case CallState.callStateBye:
        emit(
          state.copyWith(
            localRenderer: state.localRenderer..srcObject = null,
            remoteRenderer: state.remoteRenderer..srcObject = null,
            inCalling: false,
            session: null,
          ),
        );
      case CallState.callStateInvite:
        emitPresentation(LivechatEvent.showInviteDialog());
      case CallState.callStateConnected:
        emit(state.copyWith(inCalling: true));
    }
  }

  Future<void> _onSignalingStateChange(
    _SignalingStateChange event,
    Emitter<LivechatState> emit,
  ) async {
    switch (event.state) {
      case SignalingState.connectionClosed:
      case SignalingState.connectionError:
      case SignalingState.connectionOpen:
        break;
    }
  }

  Future<void> _onLocalMediaStreamChange(
    _LocalMediaStreamChange event,
    Emitter<LivechatState> emit,
  ) async {
    emit(
      state.copyWith(
        localRenderer: state.localRenderer..srcObject = event.stream,
      ),
    );
  }

  Future<void> _onRemoteMediaStreamChange(
    _RemoteMediaStreamChange event,
    Emitter<LivechatState> emit,
  ) async {
    emit(
      state.copyWith(
        remoteRenderer: state.remoteRenderer..srcObject = event.stream,
      ),
    );
  }

  Future<void> _onPeersUpdate(
    _PeersUpdate event,
    Emitter<LivechatState> emit,
  ) async {
    emit(state.copyWith(peers: event.event['peers']));
  }

  // TODO error handling
  Future<void> _onAccept(_Accept event, Emitter<LivechatState> emit) async {
    final session = state.session;
    if (session == null) return;

    await _signaling.accept(state.selfId, session.sid, 'video');
    emit(state.copyWith(inCalling: true));
  }

  Future<void> _onReject(_Reject event, Emitter<LivechatState> emit) async {
    final session = state.session;
    if (session == null) return;

    await _signaling.reject(state.selfId, session.sid);
  }

  Future<void> _onHangUp(_HangUp event, Emitter<LivechatState> emit) async {
    final session = state.session;
    if (session == null) return;

    _signaling.bye(state.selfId, session.sid);
  }

  Future<void> _onInvitePeer(
    _InvitePeer event,
    Emitter<LivechatState> emit,
  ) async {
    _signaling.invite(state.selfId, event.peerId, 'video');
  }

  Future<void> _onToggleMicrophone(
    _ToggleMicrophone event,
    Emitter<LivechatState> emit,
  ) async {
    _signaling.toggleMicrophone();
  }

  Future<void> _onSwitchCamera(
    _SwitchCamera event,
    Emitter<LivechatState> emit,
  ) async {
    await _signaling.switchCamera();
  }

  Future<void> _initRenderers() async {
    await state.localRenderer.initialize();
    await state.remoteRenderer.initialize();
  }

  @override
  Future<void> close() async {
    await _signaling.close();
    await state.localRenderer.dispose();
    await state.remoteRenderer.dispose();
    return super.close();
  }
}
