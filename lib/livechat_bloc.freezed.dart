// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'livechat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LivechatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivechatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent()';
}


}

/// @nodoc
class $LivechatEventCopyWith<$Res>  {
$LivechatEventCopyWith(LivechatEvent _, $Res Function(LivechatEvent) __);
}


/// Adds pattern-matching-related methods to [LivechatEvent].
extension LivechatEventPatterns on LivechatEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initialize value)?  initialize,TResult Function( _CallStateChange value)?  callStateChange,TResult Function( _SignalingStateChange value)?  signalingStateChange,TResult Function( _LocalMediaStreamChange value)?  localMediaStreamChange,TResult Function( _RemoteMediaStreamChange value)?  remoteMediaStreamChange,TResult Function( _PeersUpdate value)?  peersUpdate,TResult Function( ShowAcceptDialog value)?  showAcceptDialog,TResult Function( ShowInviteDialog value)?  showInviteDialog,TResult Function( _Accept value)?  accept,TResult Function( _Reject value)?  reject,TResult Function( _HangUp value)?  hangUp,TResult Function( _InvitePeer value)?  invitePeer,TResult Function( _ToggleMicrophone value)?  toggleMicrophone,TResult Function( _SwitchCamera value)?  switchCamera,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _CallStateChange() when callStateChange != null:
return callStateChange(_that);case _SignalingStateChange() when signalingStateChange != null:
return signalingStateChange(_that);case _LocalMediaStreamChange() when localMediaStreamChange != null:
return localMediaStreamChange(_that);case _RemoteMediaStreamChange() when remoteMediaStreamChange != null:
return remoteMediaStreamChange(_that);case _PeersUpdate() when peersUpdate != null:
return peersUpdate(_that);case ShowAcceptDialog() when showAcceptDialog != null:
return showAcceptDialog(_that);case ShowInviteDialog() when showInviteDialog != null:
return showInviteDialog(_that);case _Accept() when accept != null:
return accept(_that);case _Reject() when reject != null:
return reject(_that);case _HangUp() when hangUp != null:
return hangUp(_that);case _InvitePeer() when invitePeer != null:
return invitePeer(_that);case _ToggleMicrophone() when toggleMicrophone != null:
return toggleMicrophone(_that);case _SwitchCamera() when switchCamera != null:
return switchCamera(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initialize value)  initialize,required TResult Function( _CallStateChange value)  callStateChange,required TResult Function( _SignalingStateChange value)  signalingStateChange,required TResult Function( _LocalMediaStreamChange value)  localMediaStreamChange,required TResult Function( _RemoteMediaStreamChange value)  remoteMediaStreamChange,required TResult Function( _PeersUpdate value)  peersUpdate,required TResult Function( ShowAcceptDialog value)  showAcceptDialog,required TResult Function( ShowInviteDialog value)  showInviteDialog,required TResult Function( _Accept value)  accept,required TResult Function( _Reject value)  reject,required TResult Function( _HangUp value)  hangUp,required TResult Function( _InvitePeer value)  invitePeer,required TResult Function( _ToggleMicrophone value)  toggleMicrophone,required TResult Function( _SwitchCamera value)  switchCamera,}){
final _that = this;
switch (_that) {
case _Initialize():
return initialize(_that);case _CallStateChange():
return callStateChange(_that);case _SignalingStateChange():
return signalingStateChange(_that);case _LocalMediaStreamChange():
return localMediaStreamChange(_that);case _RemoteMediaStreamChange():
return remoteMediaStreamChange(_that);case _PeersUpdate():
return peersUpdate(_that);case ShowAcceptDialog():
return showAcceptDialog(_that);case ShowInviteDialog():
return showInviteDialog(_that);case _Accept():
return accept(_that);case _Reject():
return reject(_that);case _HangUp():
return hangUp(_that);case _InvitePeer():
return invitePeer(_that);case _ToggleMicrophone():
return toggleMicrophone(_that);case _SwitchCamera():
return switchCamera(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initialize value)?  initialize,TResult? Function( _CallStateChange value)?  callStateChange,TResult? Function( _SignalingStateChange value)?  signalingStateChange,TResult? Function( _LocalMediaStreamChange value)?  localMediaStreamChange,TResult? Function( _RemoteMediaStreamChange value)?  remoteMediaStreamChange,TResult? Function( _PeersUpdate value)?  peersUpdate,TResult? Function( ShowAcceptDialog value)?  showAcceptDialog,TResult? Function( ShowInviteDialog value)?  showInviteDialog,TResult? Function( _Accept value)?  accept,TResult? Function( _Reject value)?  reject,TResult? Function( _HangUp value)?  hangUp,TResult? Function( _InvitePeer value)?  invitePeer,TResult? Function( _ToggleMicrophone value)?  toggleMicrophone,TResult? Function( _SwitchCamera value)?  switchCamera,}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _CallStateChange() when callStateChange != null:
return callStateChange(_that);case _SignalingStateChange() when signalingStateChange != null:
return signalingStateChange(_that);case _LocalMediaStreamChange() when localMediaStreamChange != null:
return localMediaStreamChange(_that);case _RemoteMediaStreamChange() when remoteMediaStreamChange != null:
return remoteMediaStreamChange(_that);case _PeersUpdate() when peersUpdate != null:
return peersUpdate(_that);case ShowAcceptDialog() when showAcceptDialog != null:
return showAcceptDialog(_that);case ShowInviteDialog() when showInviteDialog != null:
return showInviteDialog(_that);case _Accept() when accept != null:
return accept(_that);case _Reject() when reject != null:
return reject(_that);case _HangUp() when hangUp != null:
return hangUp(_that);case _InvitePeer() when invitePeer != null:
return invitePeer(_that);case _ToggleMicrophone() when toggleMicrophone != null:
return toggleMicrophone(_that);case _SwitchCamera() when switchCamera != null:
return switchCamera(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function( Session session,  CallState state)?  callStateChange,TResult Function( SignalingState state)?  signalingStateChange,TResult Function( MediaStream? stream)?  localMediaStreamChange,TResult Function( Session session,  MediaStream? stream)?  remoteMediaStreamChange,TResult Function( Map<String, dynamic> event)?  peersUpdate,TResult Function()?  showAcceptDialog,TResult Function()?  showInviteDialog,TResult Function()?  accept,TResult Function()?  reject,TResult Function()?  hangUp,TResult Function( String peerId)?  invitePeer,TResult Function()?  toggleMicrophone,TResult Function()?  switchCamera,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize();case _CallStateChange() when callStateChange != null:
return callStateChange(_that.session,_that.state);case _SignalingStateChange() when signalingStateChange != null:
return signalingStateChange(_that.state);case _LocalMediaStreamChange() when localMediaStreamChange != null:
return localMediaStreamChange(_that.stream);case _RemoteMediaStreamChange() when remoteMediaStreamChange != null:
return remoteMediaStreamChange(_that.session,_that.stream);case _PeersUpdate() when peersUpdate != null:
return peersUpdate(_that.event);case ShowAcceptDialog() when showAcceptDialog != null:
return showAcceptDialog();case ShowInviteDialog() when showInviteDialog != null:
return showInviteDialog();case _Accept() when accept != null:
return accept();case _Reject() when reject != null:
return reject();case _HangUp() when hangUp != null:
return hangUp();case _InvitePeer() when invitePeer != null:
return invitePeer(_that.peerId);case _ToggleMicrophone() when toggleMicrophone != null:
return toggleMicrophone();case _SwitchCamera() when switchCamera != null:
return switchCamera();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function( Session session,  CallState state)  callStateChange,required TResult Function( SignalingState state)  signalingStateChange,required TResult Function( MediaStream? stream)  localMediaStreamChange,required TResult Function( Session session,  MediaStream? stream)  remoteMediaStreamChange,required TResult Function( Map<String, dynamic> event)  peersUpdate,required TResult Function()  showAcceptDialog,required TResult Function()  showInviteDialog,required TResult Function()  accept,required TResult Function()  reject,required TResult Function()  hangUp,required TResult Function( String peerId)  invitePeer,required TResult Function()  toggleMicrophone,required TResult Function()  switchCamera,}) {final _that = this;
switch (_that) {
case _Initialize():
return initialize();case _CallStateChange():
return callStateChange(_that.session,_that.state);case _SignalingStateChange():
return signalingStateChange(_that.state);case _LocalMediaStreamChange():
return localMediaStreamChange(_that.stream);case _RemoteMediaStreamChange():
return remoteMediaStreamChange(_that.session,_that.stream);case _PeersUpdate():
return peersUpdate(_that.event);case ShowAcceptDialog():
return showAcceptDialog();case ShowInviteDialog():
return showInviteDialog();case _Accept():
return accept();case _Reject():
return reject();case _HangUp():
return hangUp();case _InvitePeer():
return invitePeer(_that.peerId);case _ToggleMicrophone():
return toggleMicrophone();case _SwitchCamera():
return switchCamera();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function( Session session,  CallState state)?  callStateChange,TResult? Function( SignalingState state)?  signalingStateChange,TResult? Function( MediaStream? stream)?  localMediaStreamChange,TResult? Function( Session session,  MediaStream? stream)?  remoteMediaStreamChange,TResult? Function( Map<String, dynamic> event)?  peersUpdate,TResult? Function()?  showAcceptDialog,TResult? Function()?  showInviteDialog,TResult? Function()?  accept,TResult? Function()?  reject,TResult? Function()?  hangUp,TResult? Function( String peerId)?  invitePeer,TResult? Function()?  toggleMicrophone,TResult? Function()?  switchCamera,}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize();case _CallStateChange() when callStateChange != null:
return callStateChange(_that.session,_that.state);case _SignalingStateChange() when signalingStateChange != null:
return signalingStateChange(_that.state);case _LocalMediaStreamChange() when localMediaStreamChange != null:
return localMediaStreamChange(_that.stream);case _RemoteMediaStreamChange() when remoteMediaStreamChange != null:
return remoteMediaStreamChange(_that.session,_that.stream);case _PeersUpdate() when peersUpdate != null:
return peersUpdate(_that.event);case ShowAcceptDialog() when showAcceptDialog != null:
return showAcceptDialog();case ShowInviteDialog() when showInviteDialog != null:
return showInviteDialog();case _Accept() when accept != null:
return accept();case _Reject() when reject != null:
return reject();case _HangUp() when hangUp != null:
return hangUp();case _InvitePeer() when invitePeer != null:
return invitePeer(_that.peerId);case _ToggleMicrophone() when toggleMicrophone != null:
return toggleMicrophone();case _SwitchCamera() when switchCamera != null:
return switchCamera();case _:
  return null;

}
}

}

/// @nodoc


class _Initialize implements LivechatEvent {
  const _Initialize();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent.initialize()';
}


}




/// @nodoc


class _CallStateChange implements LivechatEvent {
  const _CallStateChange({required this.session, required this.state});
  

 final  Session session;
 final  CallState state;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallStateChangeCopyWith<_CallStateChange> get copyWith => __$CallStateChangeCopyWithImpl<_CallStateChange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallStateChange&&(identical(other.session, session) || other.session == session)&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,session,state);

@override
String toString() {
  return 'LivechatEvent.callStateChange(session: $session, state: $state)';
}


}

/// @nodoc
abstract mixin class _$CallStateChangeCopyWith<$Res> implements $LivechatEventCopyWith<$Res> {
  factory _$CallStateChangeCopyWith(_CallStateChange value, $Res Function(_CallStateChange) _then) = __$CallStateChangeCopyWithImpl;
@useResult
$Res call({
 Session session, CallState state
});




}
/// @nodoc
class __$CallStateChangeCopyWithImpl<$Res>
    implements _$CallStateChangeCopyWith<$Res> {
  __$CallStateChangeCopyWithImpl(this._self, this._then);

  final _CallStateChange _self;
  final $Res Function(_CallStateChange) _then;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,Object? state = null,}) {
  return _then(_CallStateChange(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallState,
  ));
}


}

/// @nodoc


class _SignalingStateChange implements LivechatEvent {
  const _SignalingStateChange({required this.state});
  

 final  SignalingState state;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignalingStateChangeCopyWith<_SignalingStateChange> get copyWith => __$SignalingStateChangeCopyWithImpl<_SignalingStateChange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignalingStateChange&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'LivechatEvent.signalingStateChange(state: $state)';
}


}

/// @nodoc
abstract mixin class _$SignalingStateChangeCopyWith<$Res> implements $LivechatEventCopyWith<$Res> {
  factory _$SignalingStateChangeCopyWith(_SignalingStateChange value, $Res Function(_SignalingStateChange) _then) = __$SignalingStateChangeCopyWithImpl;
@useResult
$Res call({
 SignalingState state
});




}
/// @nodoc
class __$SignalingStateChangeCopyWithImpl<$Res>
    implements _$SignalingStateChangeCopyWith<$Res> {
  __$SignalingStateChangeCopyWithImpl(this._self, this._then);

  final _SignalingStateChange _self;
  final $Res Function(_SignalingStateChange) _then;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = null,}) {
  return _then(_SignalingStateChange(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as SignalingState,
  ));
}


}

/// @nodoc


class _LocalMediaStreamChange implements LivechatEvent {
  const _LocalMediaStreamChange({required this.stream});
  

 final  MediaStream? stream;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalMediaStreamChangeCopyWith<_LocalMediaStreamChange> get copyWith => __$LocalMediaStreamChangeCopyWithImpl<_LocalMediaStreamChange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalMediaStreamChange&&(identical(other.stream, stream) || other.stream == stream));
}


@override
int get hashCode => Object.hash(runtimeType,stream);

@override
String toString() {
  return 'LivechatEvent.localMediaStreamChange(stream: $stream)';
}


}

/// @nodoc
abstract mixin class _$LocalMediaStreamChangeCopyWith<$Res> implements $LivechatEventCopyWith<$Res> {
  factory _$LocalMediaStreamChangeCopyWith(_LocalMediaStreamChange value, $Res Function(_LocalMediaStreamChange) _then) = __$LocalMediaStreamChangeCopyWithImpl;
@useResult
$Res call({
 MediaStream? stream
});




}
/// @nodoc
class __$LocalMediaStreamChangeCopyWithImpl<$Res>
    implements _$LocalMediaStreamChangeCopyWith<$Res> {
  __$LocalMediaStreamChangeCopyWithImpl(this._self, this._then);

  final _LocalMediaStreamChange _self;
  final $Res Function(_LocalMediaStreamChange) _then;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stream = freezed,}) {
  return _then(_LocalMediaStreamChange(
stream: freezed == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as MediaStream?,
  ));
}


}

/// @nodoc


class _RemoteMediaStreamChange implements LivechatEvent {
  const _RemoteMediaStreamChange({required this.session, required this.stream});
  

 final  Session session;
 final  MediaStream? stream;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteMediaStreamChangeCopyWith<_RemoteMediaStreamChange> get copyWith => __$RemoteMediaStreamChangeCopyWithImpl<_RemoteMediaStreamChange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteMediaStreamChange&&(identical(other.session, session) || other.session == session)&&(identical(other.stream, stream) || other.stream == stream));
}


@override
int get hashCode => Object.hash(runtimeType,session,stream);

@override
String toString() {
  return 'LivechatEvent.remoteMediaStreamChange(session: $session, stream: $stream)';
}


}

/// @nodoc
abstract mixin class _$RemoteMediaStreamChangeCopyWith<$Res> implements $LivechatEventCopyWith<$Res> {
  factory _$RemoteMediaStreamChangeCopyWith(_RemoteMediaStreamChange value, $Res Function(_RemoteMediaStreamChange) _then) = __$RemoteMediaStreamChangeCopyWithImpl;
@useResult
$Res call({
 Session session, MediaStream? stream
});




}
/// @nodoc
class __$RemoteMediaStreamChangeCopyWithImpl<$Res>
    implements _$RemoteMediaStreamChangeCopyWith<$Res> {
  __$RemoteMediaStreamChangeCopyWithImpl(this._self, this._then);

  final _RemoteMediaStreamChange _self;
  final $Res Function(_RemoteMediaStreamChange) _then;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,Object? stream = freezed,}) {
  return _then(_RemoteMediaStreamChange(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,stream: freezed == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as MediaStream?,
  ));
}


}

/// @nodoc


class _PeersUpdate implements LivechatEvent {
  const _PeersUpdate({required final  Map<String, dynamic> event}): _event = event;
  

 final  Map<String, dynamic> _event;
 Map<String, dynamic> get event {
  if (_event is EqualUnmodifiableMapView) return _event;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_event);
}


/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeersUpdateCopyWith<_PeersUpdate> get copyWith => __$PeersUpdateCopyWithImpl<_PeersUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeersUpdate&&const DeepCollectionEquality().equals(other._event, _event));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_event));

@override
String toString() {
  return 'LivechatEvent.peersUpdate(event: $event)';
}


}

/// @nodoc
abstract mixin class _$PeersUpdateCopyWith<$Res> implements $LivechatEventCopyWith<$Res> {
  factory _$PeersUpdateCopyWith(_PeersUpdate value, $Res Function(_PeersUpdate) _then) = __$PeersUpdateCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> event
});




}
/// @nodoc
class __$PeersUpdateCopyWithImpl<$Res>
    implements _$PeersUpdateCopyWith<$Res> {
  __$PeersUpdateCopyWithImpl(this._self, this._then);

  final _PeersUpdate _self;
  final $Res Function(_PeersUpdate) _then;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(_PeersUpdate(
event: null == event ? _self._event : event // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class ShowAcceptDialog implements LivechatEvent {
  const ShowAcceptDialog();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowAcceptDialog);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent.showAcceptDialog()';
}


}




/// @nodoc


class ShowInviteDialog implements LivechatEvent {
  const ShowInviteDialog();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowInviteDialog);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent.showInviteDialog()';
}


}




/// @nodoc


class _Accept implements LivechatEvent {
  const _Accept();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Accept);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent.accept()';
}


}




/// @nodoc


class _Reject implements LivechatEvent {
  const _Reject();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reject);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent.reject()';
}


}




/// @nodoc


class _HangUp implements LivechatEvent {
  const _HangUp();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HangUp);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent.hangUp()';
}


}




/// @nodoc


class _InvitePeer implements LivechatEvent {
  const _InvitePeer({required this.peerId});
  

 final  String peerId;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitePeerCopyWith<_InvitePeer> get copyWith => __$InvitePeerCopyWithImpl<_InvitePeer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitePeer&&(identical(other.peerId, peerId) || other.peerId == peerId));
}


@override
int get hashCode => Object.hash(runtimeType,peerId);

@override
String toString() {
  return 'LivechatEvent.invitePeer(peerId: $peerId)';
}


}

/// @nodoc
abstract mixin class _$InvitePeerCopyWith<$Res> implements $LivechatEventCopyWith<$Res> {
  factory _$InvitePeerCopyWith(_InvitePeer value, $Res Function(_InvitePeer) _then) = __$InvitePeerCopyWithImpl;
@useResult
$Res call({
 String peerId
});




}
/// @nodoc
class __$InvitePeerCopyWithImpl<$Res>
    implements _$InvitePeerCopyWith<$Res> {
  __$InvitePeerCopyWithImpl(this._self, this._then);

  final _InvitePeer _self;
  final $Res Function(_InvitePeer) _then;

/// Create a copy of LivechatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? peerId = null,}) {
  return _then(_InvitePeer(
peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToggleMicrophone implements LivechatEvent {
  const _ToggleMicrophone();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleMicrophone);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent.toggleMicrophone()';
}


}




/// @nodoc


class _SwitchCamera implements LivechatEvent {
  const _SwitchCamera();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwitchCamera);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivechatEvent.switchCamera()';
}


}




/// @nodoc
mixin _$LivechatState {

 RTCVideoRenderer get localRenderer; RTCVideoRenderer get remoteRenderer; String get selfId; bool get inCalling; Session? get session; List<dynamic> get peers;
/// Create a copy of LivechatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivechatStateCopyWith<LivechatState> get copyWith => _$LivechatStateCopyWithImpl<LivechatState>(this as LivechatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivechatState&&(identical(other.localRenderer, localRenderer) || other.localRenderer == localRenderer)&&(identical(other.remoteRenderer, remoteRenderer) || other.remoteRenderer == remoteRenderer)&&(identical(other.selfId, selfId) || other.selfId == selfId)&&(identical(other.inCalling, inCalling) || other.inCalling == inCalling)&&(identical(other.session, session) || other.session == session)&&const DeepCollectionEquality().equals(other.peers, peers));
}


@override
int get hashCode => Object.hash(runtimeType,localRenderer,remoteRenderer,selfId,inCalling,session,const DeepCollectionEquality().hash(peers));

@override
String toString() {
  return 'LivechatState(localRenderer: $localRenderer, remoteRenderer: $remoteRenderer, selfId: $selfId, inCalling: $inCalling, session: $session, peers: $peers)';
}


}

/// @nodoc
abstract mixin class $LivechatStateCopyWith<$Res>  {
  factory $LivechatStateCopyWith(LivechatState value, $Res Function(LivechatState) _then) = _$LivechatStateCopyWithImpl;
@useResult
$Res call({
 RTCVideoRenderer localRenderer, RTCVideoRenderer remoteRenderer, String selfId, bool inCalling, Session? session, List<dynamic> peers
});




}
/// @nodoc
class _$LivechatStateCopyWithImpl<$Res>
    implements $LivechatStateCopyWith<$Res> {
  _$LivechatStateCopyWithImpl(this._self, this._then);

  final LivechatState _self;
  final $Res Function(LivechatState) _then;

/// Create a copy of LivechatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localRenderer = null,Object? remoteRenderer = null,Object? selfId = null,Object? inCalling = null,Object? session = freezed,Object? peers = null,}) {
  return _then(_self.copyWith(
localRenderer: null == localRenderer ? _self.localRenderer : localRenderer // ignore: cast_nullable_to_non_nullable
as RTCVideoRenderer,remoteRenderer: null == remoteRenderer ? _self.remoteRenderer : remoteRenderer // ignore: cast_nullable_to_non_nullable
as RTCVideoRenderer,selfId: null == selfId ? _self.selfId : selfId // ignore: cast_nullable_to_non_nullable
as String,inCalling: null == inCalling ? _self.inCalling : inCalling // ignore: cast_nullable_to_non_nullable
as bool,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session?,peers: null == peers ? _self.peers : peers // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [LivechatState].
extension LivechatStatePatterns on LivechatState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivechatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivechatState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivechatState value)  $default,){
final _that = this;
switch (_that) {
case _LivechatState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivechatState value)?  $default,){
final _that = this;
switch (_that) {
case _LivechatState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RTCVideoRenderer localRenderer,  RTCVideoRenderer remoteRenderer,  String selfId,  bool inCalling,  Session? session,  List<dynamic> peers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivechatState() when $default != null:
return $default(_that.localRenderer,_that.remoteRenderer,_that.selfId,_that.inCalling,_that.session,_that.peers);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RTCVideoRenderer localRenderer,  RTCVideoRenderer remoteRenderer,  String selfId,  bool inCalling,  Session? session,  List<dynamic> peers)  $default,) {final _that = this;
switch (_that) {
case _LivechatState():
return $default(_that.localRenderer,_that.remoteRenderer,_that.selfId,_that.inCalling,_that.session,_that.peers);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RTCVideoRenderer localRenderer,  RTCVideoRenderer remoteRenderer,  String selfId,  bool inCalling,  Session? session,  List<dynamic> peers)?  $default,) {final _that = this;
switch (_that) {
case _LivechatState() when $default != null:
return $default(_that.localRenderer,_that.remoteRenderer,_that.selfId,_that.inCalling,_that.session,_that.peers);case _:
  return null;

}
}

}

/// @nodoc


class _LivechatState implements LivechatState {
  const _LivechatState({required this.localRenderer, required this.remoteRenderer, required this.selfId, this.inCalling = false, this.session, final  List<dynamic> peers = const []}): _peers = peers;
  

@override final  RTCVideoRenderer localRenderer;
@override final  RTCVideoRenderer remoteRenderer;
@override final  String selfId;
@override@JsonKey() final  bool inCalling;
@override final  Session? session;
 final  List<dynamic> _peers;
@override@JsonKey() List<dynamic> get peers {
  if (_peers is EqualUnmodifiableListView) return _peers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_peers);
}


/// Create a copy of LivechatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivechatStateCopyWith<_LivechatState> get copyWith => __$LivechatStateCopyWithImpl<_LivechatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivechatState&&(identical(other.localRenderer, localRenderer) || other.localRenderer == localRenderer)&&(identical(other.remoteRenderer, remoteRenderer) || other.remoteRenderer == remoteRenderer)&&(identical(other.selfId, selfId) || other.selfId == selfId)&&(identical(other.inCalling, inCalling) || other.inCalling == inCalling)&&(identical(other.session, session) || other.session == session)&&const DeepCollectionEquality().equals(other._peers, _peers));
}


@override
int get hashCode => Object.hash(runtimeType,localRenderer,remoteRenderer,selfId,inCalling,session,const DeepCollectionEquality().hash(_peers));

@override
String toString() {
  return 'LivechatState(localRenderer: $localRenderer, remoteRenderer: $remoteRenderer, selfId: $selfId, inCalling: $inCalling, session: $session, peers: $peers)';
}


}

/// @nodoc
abstract mixin class _$LivechatStateCopyWith<$Res> implements $LivechatStateCopyWith<$Res> {
  factory _$LivechatStateCopyWith(_LivechatState value, $Res Function(_LivechatState) _then) = __$LivechatStateCopyWithImpl;
@override @useResult
$Res call({
 RTCVideoRenderer localRenderer, RTCVideoRenderer remoteRenderer, String selfId, bool inCalling, Session? session, List<dynamic> peers
});




}
/// @nodoc
class __$LivechatStateCopyWithImpl<$Res>
    implements _$LivechatStateCopyWith<$Res> {
  __$LivechatStateCopyWithImpl(this._self, this._then);

  final _LivechatState _self;
  final $Res Function(_LivechatState) _then;

/// Create a copy of LivechatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localRenderer = null,Object? remoteRenderer = null,Object? selfId = null,Object? inCalling = null,Object? session = freezed,Object? peers = null,}) {
  return _then(_LivechatState(
localRenderer: null == localRenderer ? _self.localRenderer : localRenderer // ignore: cast_nullable_to_non_nullable
as RTCVideoRenderer,remoteRenderer: null == remoteRenderer ? _self.remoteRenderer : remoteRenderer // ignore: cast_nullable_to_non_nullable
as RTCVideoRenderer,selfId: null == selfId ? _self.selfId : selfId // ignore: cast_nullable_to_non_nullable
as String,inCalling: null == inCalling ? _self.inCalling : inCalling // ignore: cast_nullable_to_non_nullable
as bool,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session?,peers: null == peers ? _self._peers : peers // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
