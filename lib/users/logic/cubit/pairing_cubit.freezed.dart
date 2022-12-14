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
  PairingRequestData? get receivedPairingRequest =>
      throw _privateConstructorUsedError;
  PairingResponseData? get receivedPairingResponse =>
      throw _privateConstructorUsedError;

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
      PairingRequestData? receivedPairingRequest,
      PairingResponseData? receivedPairingResponse});
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
    Object? receivedPairingRequest = freezed,
    Object? receivedPairingResponse = freezed,
  }) {
    return _then(_value.copyWith(
      pairingRequested: pairingRequested == freezed
          ? _value.pairingRequested
          : pairingRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      receivedPairingRequest: receivedPairingRequest == freezed
          ? _value.receivedPairingRequest
          : receivedPairingRequest // ignore: cast_nullable_to_non_nullable
              as PairingRequestData?,
      receivedPairingResponse: receivedPairingResponse == freezed
          ? _value.receivedPairingResponse
          : receivedPairingResponse // ignore: cast_nullable_to_non_nullable
              as PairingResponseData?,
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
      PairingRequestData? receivedPairingRequest,
      PairingResponseData? receivedPairingResponse});
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
    Object? receivedPairingRequest = freezed,
    Object? receivedPairingResponse = freezed,
  }) {
    return _then(_$_PairingState(
      pairingRequested: pairingRequested == freezed
          ? _value.pairingRequested
          : pairingRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      receivedPairingRequest: receivedPairingRequest == freezed
          ? _value.receivedPairingRequest
          : receivedPairingRequest // ignore: cast_nullable_to_non_nullable
              as PairingRequestData?,
      receivedPairingResponse: receivedPairingResponse == freezed
          ? _value.receivedPairingResponse
          : receivedPairingResponse // ignore: cast_nullable_to_non_nullable
              as PairingResponseData?,
    ));
  }
}

/// @nodoc

class _$_PairingState extends _PairingState with DiagnosticableTreeMixin {
  _$_PairingState(
      {required this.pairingRequested,
      this.receivedPairingRequest,
      this.receivedPairingResponse})
      : super._();

  @override
  final bool pairingRequested;
  @override
  final PairingRequestData? receivedPairingRequest;
  @override
  final PairingResponseData? receivedPairingResponse;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PairingState(pairingRequested: $pairingRequested, receivedPairingRequest: $receivedPairingRequest, receivedPairingResponse: $receivedPairingResponse)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PairingState'))
      ..add(DiagnosticsProperty('pairingRequested', pairingRequested))
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
            const DeepCollectionEquality()
                .equals(other.receivedPairingRequest, receivedPairingRequest) &&
            const DeepCollectionEquality().equals(
                other.receivedPairingResponse, receivedPairingResponse));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pairingRequested),
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
      final PairingRequestData? receivedPairingRequest,
      final PairingResponseData? receivedPairingResponse}) = _$_PairingState;
  _PairingState._() : super._();

  @override
  bool get pairingRequested;
  @override
  PairingRequestData? get receivedPairingRequest;
  @override
  PairingResponseData? get receivedPairingResponse;
  @override
  @JsonKey(ignore: true)
  _$$_PairingStateCopyWith<_$_PairingState> get copyWith =>
      throw _privateConstructorUsedError;
}
