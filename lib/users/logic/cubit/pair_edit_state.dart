part of 'pair_edit_cubit.dart';

@freezed
class PairEditState with _$PairEditState {
  const PairEditState._();
  factory PairEditState({
    required String pair,
    required int focusedCellIndex,
    required List<String> code,
  }) = _PairEditState;
}
