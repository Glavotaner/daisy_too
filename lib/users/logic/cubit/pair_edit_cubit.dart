import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pair_edit_state.dart';
part 'pair_edit_cubit.freezed.dart';

class PairEditCubit extends Cubit<PairEditState> {
  PairEditCubit()
      : super(PairEditState(
          pair: '',
          code: List.generate(6, (_) => ''),
          focusedCellIndex: 0,
        ));

  onPairChange(String pair) {
    emit(state.copyWith(pair: pair));
  }

  onCodeChange(String value) {
    final code = [...state.code];
    final cellIndex = state.focusedCellIndex;
    code[cellIndex] = value;
    int focusedCellIndex = state.focusedCellIndex;
    if (value.isEmpty && focusedCellIndex > 0) {
      focusedCellIndex--;
    } else if (value.isNotEmpty && focusedCellIndex != 5) {
      focusedCellIndex++;
    }
    emit(state.copyWith(
      code: code,
      focusedCellIndex: focusedCellIndex,
    ));
  }

  onCellChange(int index) {
    emit(state.copyWith(focusedCellIndex: index));
  }

  copyPairingCode() async {
    await Clipboard.setData(
      ClipboardData(text: state.code.join('')),
    );
  }

  clearPairingState() {
    emit(state.copyWith(
      pair: '',
      code: List.generate(6, (_) => ''),
      focusedCellIndex: 0,
    ));
  }
}
