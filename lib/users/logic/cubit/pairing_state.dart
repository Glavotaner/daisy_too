part of 'pairing_cubit.dart';

@freezed
class PairingState with _$PairingState {
  const PairingState._();
  factory PairingState({
    required bool requestReceived,
    required bool pairingRequested,
    required bool requestSent,
    required bool responseSent,
    required String pair,
    required int focusedCellIndex,
    required List<String> code,
  }) = _PairingState;
  static PairingState get initial => PairingState(
        requestReceived: false,
        requestSent: false,
        responseSent: false,
        pairingRequested: false,
        pair: '',
        code: List.generate(6, (_) => ''),
        focusedCellIndex: 0,
      );

  String get pairingCode => code.join();
  bool get codeComplete => pairingCode.length == 6;
}
