part of 'pairing_cubit.dart';

@freezed
class PairingState with _$PairingState {
  const PairingState._();
  factory PairingState({
    required bool pairingRequested,
    required bool sentPairingRequest,
    Message? receivedPairingRequest,
    Message? receivedPairingResponse,
  }) = _PairingState;
  static PairingState get initial => PairingState(
        pairingRequested: false,
        receivedPairingResponse: null,
        receivedPairingRequest: null,
        sentPairingRequest: false,
      );
}
