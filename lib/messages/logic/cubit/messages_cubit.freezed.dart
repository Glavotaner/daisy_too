// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'messages_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessageState {
  bool get sending => throw _privateConstructorUsedError;
  Message? get receivedMessage => throw _privateConstructorUsedError;
  Message? get sentMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageStateCopyWith<MessageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageStateCopyWith<$Res> {
  factory $MessageStateCopyWith(
          MessageState value, $Res Function(MessageState) then) =
      _$MessageStateCopyWithImpl<$Res>;
  $Res call({bool sending, Message? receivedMessage, Message? sentMessage});
}

/// @nodoc
class _$MessageStateCopyWithImpl<$Res> implements $MessageStateCopyWith<$Res> {
  _$MessageStateCopyWithImpl(this._value, this._then);

  final MessageState _value;
  // ignore: unused_field
  final $Res Function(MessageState) _then;

  @override
  $Res call({
    Object? sending = freezed,
    Object? receivedMessage = freezed,
    Object? sentMessage = freezed,
  }) {
    return _then(_value.copyWith(
      sending: sending == freezed
          ? _value.sending
          : sending // ignore: cast_nullable_to_non_nullable
              as bool,
      receivedMessage: receivedMessage == freezed
          ? _value.receivedMessage
          : receivedMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      sentMessage: sentMessage == freezed
          ? _value.sentMessage
          : sentMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageStateCopyWith<$Res>
    implements $MessageStateCopyWith<$Res> {
  factory _$$_MessageStateCopyWith(
          _$_MessageState value, $Res Function(_$_MessageState) then) =
      __$$_MessageStateCopyWithImpl<$Res>;
  @override
  $Res call({bool sending, Message? receivedMessage, Message? sentMessage});
}

/// @nodoc
class __$$_MessageStateCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res>
    implements _$$_MessageStateCopyWith<$Res> {
  __$$_MessageStateCopyWithImpl(
      _$_MessageState _value, $Res Function(_$_MessageState) _then)
      : super(_value, (v) => _then(v as _$_MessageState));

  @override
  _$_MessageState get _value => super._value as _$_MessageState;

  @override
  $Res call({
    Object? sending = freezed,
    Object? receivedMessage = freezed,
    Object? sentMessage = freezed,
  }) {
    return _then(_$_MessageState(
      sending: sending == freezed
          ? _value.sending
          : sending // ignore: cast_nullable_to_non_nullable
              as bool,
      receivedMessage: receivedMessage == freezed
          ? _value.receivedMessage
          : receivedMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      sentMessage: sentMessage == freezed
          ? _value.sentMessage
          : sentMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
    ));
  }
}

/// @nodoc

class _$_MessageState extends _MessageState {
  _$_MessageState(
      {required this.sending, this.receivedMessage, this.sentMessage})
      : super._();

  @override
  final bool sending;
  @override
  final Message? receivedMessage;
  @override
  final Message? sentMessage;

  @JsonKey(ignore: true)
  @override
  _$$_MessageStateCopyWith<_$_MessageState> get copyWith =>
      __$$_MessageStateCopyWithImpl<_$_MessageState>(this, _$identity);
}

abstract class _MessageState extends MessageState {
  factory _MessageState(
      {required final bool sending,
      final Message? receivedMessage,
      final Message? sentMessage}) = _$_MessageState;
  _MessageState._() : super._();

  @override
  bool get sending;
  @override
  Message? get receivedMessage;
  @override
  Message? get sentMessage;
  @override
  @JsonKey(ignore: true)
  _$$_MessageStateCopyWith<_$_MessageState> get copyWith =>
      throw _privateConstructorUsedError;
}
