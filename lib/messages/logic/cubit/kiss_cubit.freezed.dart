// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kiss_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KissState {
  Kiss? get sentKiss => throw _privateConstructorUsedError;
  Kiss? get receivedKiss => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KissStateCopyWith<KissState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KissStateCopyWith<$Res> {
  factory $KissStateCopyWith(KissState value, $Res Function(KissState) then) =
      _$KissStateCopyWithImpl<$Res>;
  $Res call({Kiss? sentKiss, Kiss? receivedKiss});
}

/// @nodoc
class _$KissStateCopyWithImpl<$Res> implements $KissStateCopyWith<$Res> {
  _$KissStateCopyWithImpl(this._value, this._then);

  final KissState _value;
  // ignore: unused_field
  final $Res Function(KissState) _then;

  @override
  $Res call({
    Object? sentKiss = freezed,
    Object? receivedKiss = freezed,
  }) {
    return _then(_value.copyWith(
      sentKiss: sentKiss == freezed
          ? _value.sentKiss
          : sentKiss // ignore: cast_nullable_to_non_nullable
              as Kiss?,
      receivedKiss: receivedKiss == freezed
          ? _value.receivedKiss
          : receivedKiss // ignore: cast_nullable_to_non_nullable
              as Kiss?,
    ));
  }
}

/// @nodoc
abstract class _$$_KissStateCopyWith<$Res> implements $KissStateCopyWith<$Res> {
  factory _$$_KissStateCopyWith(
          _$_KissState value, $Res Function(_$_KissState) then) =
      __$$_KissStateCopyWithImpl<$Res>;
  @override
  $Res call({Kiss? sentKiss, Kiss? receivedKiss});
}

/// @nodoc
class __$$_KissStateCopyWithImpl<$Res> extends _$KissStateCopyWithImpl<$Res>
    implements _$$_KissStateCopyWith<$Res> {
  __$$_KissStateCopyWithImpl(
      _$_KissState _value, $Res Function(_$_KissState) _then)
      : super(_value, (v) => _then(v as _$_KissState));

  @override
  _$_KissState get _value => super._value as _$_KissState;

  @override
  $Res call({
    Object? sentKiss = freezed,
    Object? receivedKiss = freezed,
  }) {
    return _then(_$_KissState(
      sentKiss: sentKiss == freezed
          ? _value.sentKiss
          : sentKiss // ignore: cast_nullable_to_non_nullable
              as Kiss?,
      receivedKiss: receivedKiss == freezed
          ? _value.receivedKiss
          : receivedKiss // ignore: cast_nullable_to_non_nullable
              as Kiss?,
    ));
  }
}

/// @nodoc

class _$_KissState extends _KissState {
  _$_KissState({this.sentKiss, this.receivedKiss}) : super._();

  @override
  final Kiss? sentKiss;
  @override
  final Kiss? receivedKiss;

  @JsonKey(ignore: true)
  @override
  _$$_KissStateCopyWith<_$_KissState> get copyWith =>
      __$$_KissStateCopyWithImpl<_$_KissState>(this, _$identity);
}

abstract class _KissState extends KissState {
  factory _KissState({final Kiss? sentKiss, final Kiss? receivedKiss}) =
      _$_KissState;
  _KissState._() : super._();

  @override
  Kiss? get sentKiss;
  @override
  Kiss? get receivedKiss;
  @override
  @JsonKey(ignore: true)
  _$$_KissStateCopyWith<_$_KissState> get copyWith =>
      throw _privateConstructorUsedError;
}
