part of 'pairing_cubit.dart';

@freezed
class PairingState with _$PairingState {
  const PairingState._();
  factory PairingState({
    required bool pairingRequested,
    required String pair,
    required int focusedCellIndex,
    required List<String> code,
    required bool sentPairingRequest,
    Message? receivedPairingRequest,
    Message? receivedPairingResponse,
  }) = _PairingState;
  static PairingState get initial => PairingState(
        pairingRequested: false,
        pair: '',
        code: List.generate(6, (_) => ''),
        focusedCellIndex: 0,
        receivedPairingResponse: null,
        receivedPairingRequest: null,
        sentPairingRequest: false,
      );

  String get pairingCode => code.join();
  bool get codeComplete => pairingCode.length == 6;
}
