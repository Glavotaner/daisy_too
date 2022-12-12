part of 'pair_edit_cubit.dart';

@freezed
class PairEditState with _$PairEditState {
  const PairEditState._();
  factory PairEditState({
    required bool sendingPairingRequest,
    required bool sentPairingRequest,
    required bool sentPairingResponse,
    required String pair,
    required int focusedCellIndex,
    required List<String> code,
  }) = _PairEditState;
  factory PairEditState.initial({String? pair}) => PairEditState(
        sendingPairingRequest: false,
        sentPairingRequest: false,
        sentPairingResponse: false,
        pair: pair ?? '',
        code: initialPairingCode,
        focusedCellIndex: 0,
      );
  get codeComplete => code.where((c) => c.isNotEmpty).length == 6;
  static get initialPairingCode => List.generate(6, (_) => '');
}
