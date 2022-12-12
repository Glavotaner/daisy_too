part of 'pairing_cubit.dart';

@freezed
class PairingState with _$PairingState {
  const PairingState._();
  factory PairingState({
    required bool pairingRequested,
    PairingRequestData? receivedPairingRequest,
    PairingResponseData? receivedPairingResponse,
  }) = _PairingState;
  factory PairingState.initial() => PairingState(
        pairingRequested: false,
        receivedPairingResponse: null,
        receivedPairingRequest: null,
      );
}
