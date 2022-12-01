// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pair_edit_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PairEditState {
  String get pair => throw _privateConstructorUsedError;
  int get focusedCellIndex => throw _privateConstructorUsedError;
  List<String> get code => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PairEditStateCopyWith<PairEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairEditStateCopyWith<$Res> {
  factory $PairEditStateCopyWith(
          PairEditState value, $Res Function(PairEditState) then) =
      _$PairEditStateCopyWithImpl<$Res>;
  $Res call({String pair, int focusedCellIndex, List<String> code});
}

/// @nodoc
class _$PairEditStateCopyWithImpl<$Res>
    implements $PairEditStateCopyWith<$Res> {
  _$PairEditStateCopyWithImpl(this._value, this._then);

  final PairEditState _value;
  // ignore: unused_field
  final $Res Function(PairEditState) _then;

  @override
  $Res call({
    Object? pair = freezed,
    Object? focusedCellIndex = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      pair: pair == freezed
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as String,
      focusedCellIndex: focusedCellIndex == freezed
          ? _value.focusedCellIndex
          : focusedCellIndex // ignore: cast_nullable_to_non_nullable
              as int,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_PairEditStateCopyWith<$Res>
    implements $PairEditStateCopyWith<$Res> {
  factory _$$_PairEditStateCopyWith(
          _$_PairEditState value, $Res Function(_$_PairEditState) then) =
      __$$_PairEditStateCopyWithImpl<$Res>;
  @override
  $Res call({String pair, int focusedCellIndex, List<String> code});
}

/// @nodoc
class __$$_PairEditStateCopyWithImpl<$Res>
    extends _$PairEditStateCopyWithImpl<$Res>
    implements _$$_PairEditStateCopyWith<$Res> {
  __$$_PairEditStateCopyWithImpl(
      _$_PairEditState _value, $Res Function(_$_PairEditState) _then)
      : super(_value, (v) => _then(v as _$_PairEditState));

  @override
  _$_PairEditState get _value => super._value as _$_PairEditState;

  @override
  $Res call({
    Object? pair = freezed,
    Object? focusedCellIndex = freezed,
    Object? code = freezed,
  }) {
    return _then(_$_PairEditState(
      pair: pair == freezed
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as String,
      focusedCellIndex: focusedCellIndex == freezed
          ? _value.focusedCellIndex
          : focusedCellIndex // ignore: cast_nullable_to_non_nullable
              as int,
      code: code == freezed
          ? _value._code
          : code // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_PairEditState extends _PairEditState {
  _$_PairEditState(
      {required this.pair,
      required this.focusedCellIndex,
      required final List<String> code})
      : _code = code,
        super._();

  @override
  final String pair;
  @override
  final int focusedCellIndex;
  final List<String> _code;
  @override
  List<String> get code {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_code);
  }

  @override
  String toString() {
    return 'PairEditState(pair: $pair, focusedCellIndex: $focusedCellIndex, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PairEditState &&
            const DeepCollectionEquality().equals(other.pair, pair) &&
            const DeepCollectionEquality()
                .equals(other.focusedCellIndex, focusedCellIndex) &&
            const DeepCollectionEquality().equals(other._code, _code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pair),
      const DeepCollectionEquality().hash(focusedCellIndex),
      const DeepCollectionEquality().hash(_code));

  @JsonKey(ignore: true)
  @override
  _$$_PairEditStateCopyWith<_$_PairEditState> get copyWith =>
      __$$_PairEditStateCopyWithImpl<_$_PairEditState>(this, _$identity);
}

abstract class _PairEditState extends PairEditState {
  factory _PairEditState(
      {required final String pair,
      required final int focusedCellIndex,
      required final List<String> code}) = _$_PairEditState;
  _PairEditState._() : super._();

  @override
  String get pair;
  @override
  int get focusedCellIndex;
  @override
  List<String> get code;
  @override
  @JsonKey(ignore: true)
  _$$_PairEditStateCopyWith<_$_PairEditState> get copyWith =>
      throw _privateConstructorUsedError;
}
