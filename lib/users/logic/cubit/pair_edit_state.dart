part of 'pair_edit_cubit.dart';

@freezed
class PairEditState with _$PairEditState {
  const PairEditState._();
  factory PairEditState({
    required bool sentPairingRequest,
    required bool sentPairingResponse,
    required String pair,
    required int focusedCellIndex,
    required List<String> code,
  }) = _PairEditState;
  get codeComplete => code.where((c) => c.isNotEmpty).length == 6;
  get initialPairingCode => List.generate(6, (_) => '');
}
