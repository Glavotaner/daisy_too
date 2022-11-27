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
  bool get pairingRequested => throw _privateConstructorUsedError;
  String get pair => throw _privateConstructorUsedError;
  int get focusedCellIndex => throw _privateConstructorUsedError;
  List<String> get code => throw _privateConstructorUsedError;
  Message? get receivedPairingRequest => throw _privateConstructorUsedError;
  Message? get receivedPairingResponse => throw _privateConstructorUsedError;

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
      {bool pairingRequested,
      String pair,
      int focusedCellIndex,
      List<String> code,
      Message? receivedPairingRequest,
      Message? receivedPairingResponse});
}

/// @nodoc
class _$PairingStateCopyWithImpl<$Res> implements $PairingStateCopyWith<$Res> {
  _$PairingStateCopyWithImpl(this._value, this._then);

  final PairingState _value;
  // ignore: unused_field
  final $Res Function(PairingState) _then;

  @override
  $Res call({
    Object? pairingRequested = freezed,
    Object? pair = freezed,
    Object? focusedCellIndex = freezed,
    Object? code = freezed,
    Object? receivedPairingRequest = freezed,
    Object? receivedPairingResponse = freezed,
  }) {
    return _then(_value.copyWith(
      pairingRequested: pairingRequested == freezed
          ? _value.pairingRequested
          : pairingRequested // ignore: cast_nullable_to_non_nullable
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
      receivedPairingRequest: receivedPairingRequest == freezed
          ? _value.receivedPairingRequest
          : receivedPairingRequest // ignore: cast_nullable_to_non_nullable
              as Message?,
      receivedPairingResponse: receivedPairingResponse == freezed
          ? _value.receivedPairingResponse
          : receivedPairingResponse // ignore: cast_nullable_to_non_nullable
              as Message?,
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
      {bool pairingRequested,
      String pair,
      int focusedCellIndex,
      List<String> code,
      Message? receivedPairingRequest,
      Message? receivedPairingResponse});
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
    Object? pairingRequested = freezed,
    Object? pair = freezed,
    Object? focusedCellIndex = freezed,
    Object? code = freezed,
    Object? receivedPairingRequest = freezed,
    Object? receivedPairingResponse = freezed,
  }) {
    return _then(_$_PairingState(
      pairingRequested: pairingRequested == freezed
          ? _value.pairingRequested
          : pairingRequested // ignore: cast_nullable_to_non_nullable
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
      receivedPairingRequest: receivedPairingRequest == freezed
          ? _value.receivedPairingRequest
          : receivedPairingRequest // ignore: cast_nullable_to_non_nullable
              as Message?,
      receivedPairingResponse: receivedPairingResponse == freezed
          ? _value.receivedPairingResponse
          : receivedPairingResponse // ignore: cast_nullable_to_non_nullable
              as Message?,
    ));
  }
}

/// @nodoc

class _$_PairingState extends _PairingState with DiagnosticableTreeMixin {
  _$_PairingState(
      {required this.pairingRequested,
      required this.pair,
      required this.focusedCellIndex,
      required final List<String> code,
      this.receivedPairingRequest,
      this.receivedPairingResponse})
      : _code = code,
        super._();

  @override
  final bool pairingRequested;
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
  final Message? receivedPairingRequest;
  @override
  final Message? receivedPairingResponse;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PairingState(pairingRequested: $pairingRequested, pair: $pair, focusedCellIndex: $focusedCellIndex, code: $code, receivedPairingRequest: $receivedPairingRequest, receivedPairingResponse: $receivedPairingResponse)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PairingState'))
      ..add(DiagnosticsProperty('pairingRequested', pairingRequested))
      ..add(DiagnosticsProperty('pair', pair))
      ..add(DiagnosticsProperty('focusedCellIndex', focusedCellIndex))
      ..add(DiagnosticsProperty('code', code))
      ..add(
          DiagnosticsProperty('receivedPairingRequest', receivedPairingRequest))
      ..add(DiagnosticsProperty(
          'receivedPairingResponse', receivedPairingResponse));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PairingState &&
            const DeepCollectionEquality()
                .equals(other.pairingRequested, pairingRequested) &&
            const DeepCollectionEquality().equals(other.pair, pair) &&
            const DeepCollectionEquality()
                .equals(other.focusedCellIndex, focusedCellIndex) &&
            const DeepCollectionEquality().equals(other._code, _code) &&
            const DeepCollectionEquality()
                .equals(other.receivedPairingRequest, receivedPairingRequest) &&
            const DeepCollectionEquality().equals(
                other.receivedPairingResponse, receivedPairingResponse));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pairingRequested),
      const DeepCollectionEquality().hash(pair),
      const DeepCollectionEquality().hash(focusedCellIndex),
      const DeepCollectionEquality().hash(_code),
      const DeepCollectionEquality().hash(receivedPairingRequest),
      const DeepCollectionEquality().hash(receivedPairingResponse));

  @JsonKey(ignore: true)
  @override
  _$$_PairingStateCopyWith<_$_PairingState> get copyWith =>
      __$$_PairingStateCopyWithImpl<_$_PairingState>(this, _$identity);
}

abstract class _PairingState extends PairingState {
  factory _PairingState(
      {required final bool pairingRequested,
      required final String pair,
      required final int focusedCellIndex,
      required final List<String> code,
      final Message? receivedPairingRequest,
      final Message? receivedPairingResponse}) = _$_PairingState;
  _PairingState._() : super._();

  @override
  bool get pairingRequested;
  @override
  String get pair;
  @override
  int get focusedCellIndex;
  @override
  List<String> get code;
  @override
  Message? get receivedPairingRequest;
  @override
  Message? get receivedPairingResponse;
  @override
  @JsonKey(ignore: true)
  _$$_PairingStateCopyWith<_$_PairingState> get copyWith =>
      throw _privateConstructorUsedError;
}
