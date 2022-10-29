// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pairing_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PairingState {
  bool get requestReceived => throw _privateConstructorUsedError;
  bool get pairingRequested => throw _privateConstructorUsedError;
  bool get requestSent => throw _privateConstructorUsedError;
  bool get responseSent => throw _privateConstructorUsedError;
  String get pair => throw _privateConstructorUsedError;
  int get focusedCellIndex => throw _privateConstructorUsedError;
  List<String> get code => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PairingStateCopyWith<PairingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairingStateCopyWith<$Res> {
  factory $PairingStateCopyWith(
          PairingState value, $Res Function(PairingState) then) =
      _$PairingStateCopyWithImpl<$Res>;
  $Res call(
      {bool requestReceived,
      bool pairingRequested,
      bool requestSent,
      bool responseSent,
      String pair,
      int focusedCellIndex,
      List<String> code});
}

/// @nodoc
class _$PairingStateCopyWithImpl<$Res> implements $PairingStateCopyWith<$Res> {
  _$PairingStateCopyWithImpl(this._value, this._then);

  final PairingState _value;
  // ignore: unused_field
  final $Res Function(PairingState) _then;

  @override
  $Res call({
    Object? requestReceived = freezed,
    Object? pairingRequested = freezed,
    Object? requestSent = freezed,
    Object? responseSent = freezed,
    Object? pair = freezed,
    Object? focusedCellIndex = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      requestReceived: requestReceived == freezed
          ? _value.requestReceived
          : requestReceived // ignore: cast_nullable_to_non_nullable
              as bool,
      pairingRequested: pairingRequested == freezed
          ? _value.pairingRequested
          : pairingRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      requestSent: requestSent == freezed
          ? _value.requestSent
          : requestSent // ignore: cast_nullable_to_non_nullable
              as bool,
      responseSent: responseSent == freezed
          ? _value.responseSent
          : responseSent // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$_PairingStateCopyWith<$Res>
    implements $PairingStateCopyWith<$Res> {
  factory _$$_PairingStateCopyWith(
          _$_PairingState value, $Res Function(_$_PairingState) then) =
      __$$_PairingStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool requestReceived,
      bool pairingRequested,
      bool requestSent,
      bool responseSent,
      String pair,
      int focusedCellIndex,
      List<String> code});
}

/// @nodoc
class __$$_PairingStateCopyWithImpl<$Res>
    extends _$PairingStateCopyWithImpl<$Res>
    implements _$$_PairingStateCopyWith<$Res> {
  __$$_PairingStateCopyWithImpl(
      _$_PairingState _value, $Res Function(_$_PairingState) _then)
      : super(_value, (v) => _then(v as _$_PairingState));

  @override
  _$_PairingState get _value => super._value as _$_PairingState;

  @override
  $Res call({
    Object? requestReceived = freezed,
    Object? pairingRequested = freezed,
    Object? requestSent = freezed,
    Object? responseSent = freezed,
    Object? pair = freezed,
    Object? focusedCellIndex = freezed,
    Object? code = freezed,
  }) {
    return _then(_$_PairingState(
      requestReceived: requestReceived == freezed
          ? _value.requestReceived
          : requestReceived // ignore: cast_nullable_to_non_nullable
              as bool,
      pairingRequested: pairingRequested == freezed
          ? _value.pairingRequested
          : pairingRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      requestSent: requestSent == freezed
          ? _value.requestSent
          : requestSent // ignore: cast_nullable_to_non_nullable
              as bool,
      responseSent: responseSent == freezed
          ? _value.responseSent
          : responseSent // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$_PairingState extends _PairingState with DiagnosticableTreeMixin {
  _$_PairingState(
      {required this.requestReceived,
      required this.pairingRequested,
      required this.requestSent,
      required this.responseSent,
      required this.pair,
      required this.focusedCellIndex,
      required final List<String> code})
      : _code = code,
        super._();

  @override
  final bool requestReceived;
  @override
  final bool pairingRequested;
  @override
  final bool requestSent;
  @override
  final bool responseSent;
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PairingState(requestReceived: $requestReceived, pairingRequested: $pairingRequested, requestSent: $requestSent, responseSent: $responseSent, pair: $pair, focusedCellIndex: $focusedCellIndex, code: $code)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PairingState'))
      ..add(DiagnosticsProperty('requestReceived', requestReceived))
      ..add(DiagnosticsProperty('pairingRequested', pairingRequested))
      ..add(DiagnosticsProperty('requestSent', requestSent))
      ..add(DiagnosticsProperty('responseSent', responseSent))
      ..add(DiagnosticsProperty('pair', pair))
      ..add(DiagnosticsProperty('focusedCellIndex', focusedCellIndex))
      ..add(DiagnosticsProperty('code', code));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PairingState &&
            const DeepCollectionEquality()
                .equals(other.requestReceived, requestReceived) &&
            const DeepCollectionEquality()
                .equals(other.pairingRequested, pairingRequested) &&
            const DeepCollectionEquality()
                .equals(other.requestSent, requestSent) &&
            const DeepCollectionEquality()
                .equals(other.responseSent, responseSent) &&
            const DeepCollectionEquality().equals(other.pair, pair) &&
            const DeepCollectionEquality()
                .equals(other.focusedCellIndex, focusedCellIndex) &&
            const DeepCollectionEquality().equals(other._code, _code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(requestReceived),
      const DeepCollectionEquality().hash(pairingRequested),
      const DeepCollectionEquality().hash(requestSent),
      const DeepCollectionEquality().hash(responseSent),
      const DeepCollectionEquality().hash(pair),
      const DeepCollectionEquality().hash(focusedCellIndex),
      const DeepCollectionEquality().hash(_code));

  @JsonKey(ignore: true)
  @override
  _$$_PairingStateCopyWith<_$_PairingState> get copyWith =>
      __$$_PairingStateCopyWithImpl<_$_PairingState>(this, _$identity);
}

abstract class _PairingState extends PairingState {
  factory _PairingState(
      {required final bool requestReceived,
      required final bool pairingRequested,
      required final bool requestSent,
      required final bool responseSent,
      required final String pair,
      required final int focusedCellIndex,
      required final List<String> code}) = _$_PairingState;
  _PairingState._() : super._();

  @override
  bool get requestReceived;
  @override
  bool get pairingRequested;
  @override
  bool get requestSent;
  @override
  bool get responseSent;
  @override
  String get pair;
  @override
  int get focusedCellIndex;
  @override
  List<String> get code;
  @override
  @JsonKey(ignore: true)
  _$$_PairingStateCopyWith<_$_PairingState> get copyWith =>
      throw _privateConstructorUsedError;
}
