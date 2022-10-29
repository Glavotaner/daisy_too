// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'status_notifier_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StatusNotifierState {
  SnackBar? get snackBar => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatusNotifierStateCopyWith<StatusNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusNotifierStateCopyWith<$Res> {
  factory $StatusNotifierStateCopyWith(
          StatusNotifierState value, $Res Function(StatusNotifierState) then) =
      _$StatusNotifierStateCopyWithImpl<$Res>;
  $Res call({SnackBar? snackBar});
}

/// @nodoc
class _$StatusNotifierStateCopyWithImpl<$Res>
    implements $StatusNotifierStateCopyWith<$Res> {
  _$StatusNotifierStateCopyWithImpl(this._value, this._then);

  final StatusNotifierState _value;
  // ignore: unused_field
  final $Res Function(StatusNotifierState) _then;

  @override
  $Res call({
    Object? snackBar = freezed,
  }) {
    return _then(_value.copyWith(
      snackBar: snackBar == freezed
          ? _value.snackBar
          : snackBar // ignore: cast_nullable_to_non_nullable
              as SnackBar?,
    ));
  }
}

/// @nodoc
abstract class _$$_StatusNotifierStateCopyWith<$Res>
    implements $StatusNotifierStateCopyWith<$Res> {
  factory _$$_StatusNotifierStateCopyWith(_$_StatusNotifierState value,
          $Res Function(_$_StatusNotifierState) then) =
      __$$_StatusNotifierStateCopyWithImpl<$Res>;
  @override
  $Res call({SnackBar? snackBar});
}

/// @nodoc
class __$$_StatusNotifierStateCopyWithImpl<$Res>
    extends _$StatusNotifierStateCopyWithImpl<$Res>
    implements _$$_StatusNotifierStateCopyWith<$Res> {
  __$$_StatusNotifierStateCopyWithImpl(_$_StatusNotifierState _value,
      $Res Function(_$_StatusNotifierState) _then)
      : super(_value, (v) => _then(v as _$_StatusNotifierState));

  @override
  _$_StatusNotifierState get _value => super._value as _$_StatusNotifierState;

  @override
  $Res call({
    Object? snackBar = freezed,
  }) {
    return _then(_$_StatusNotifierState(
      snackBar: snackBar == freezed
          ? _value.snackBar
          : snackBar // ignore: cast_nullable_to_non_nullable
              as SnackBar?,
    ));
  }
}

/// @nodoc

class _$_StatusNotifierState implements _StatusNotifierState {
  const _$_StatusNotifierState({this.snackBar});

  @override
  final SnackBar? snackBar;

  @override
  String toString() {
    return 'StatusNotifierState(snackBar: $snackBar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StatusNotifierState &&
            const DeepCollectionEquality().equals(other.snackBar, snackBar));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(snackBar));

  @JsonKey(ignore: true)
  @override
  _$$_StatusNotifierStateCopyWith<_$_StatusNotifierState> get copyWith =>
      __$$_StatusNotifierStateCopyWithImpl<_$_StatusNotifierState>(
          this, _$identity);
}

abstract class _StatusNotifierState implements StatusNotifierState {
  const factory _StatusNotifierState({final SnackBar? snackBar}) =
      _$_StatusNotifierState;

  @override
  SnackBar? get snackBar;
  @override
  @JsonKey(ignore: true)
  _$$_StatusNotifierStateCopyWith<_$_StatusNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}
