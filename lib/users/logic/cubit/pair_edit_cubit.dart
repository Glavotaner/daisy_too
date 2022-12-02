import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:daisy_too/main.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_api/implementation/web_api_http.dart';

part 'pair_edit_state.dart';
part 'pair_edit_cubit.freezed.dart';

class PairEditCubit extends Cubit<PairEditState> {
  PairEditCubit()
      : super(PairEditState(
          sentPairingRequest: false,
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

  clearSentRequest() {
    emit(state.copyWith(sentPairingRequest: false));
  }

  sendPairingRequest({
    required String requestingUsername,
  }) async {
    try {
      await users.requestPair(
        requestingUsername: requestingUsername,
        pairUsername: state.pair,
      );
      emit(state.copyWith(sentPairingRequest: true));
    } catch (exception) {
      log(exception.toString());
      if (exception is BadRequest) {
        // statusNotifier.showError(exception.message);
      }
    }
  }

  sendPairingResponse({
    required String requestingUsername,
  }) async {
    try {
      await users.respondPair(
        pairingResponse: state.code.join(''),
        respondingUsername: state.pair,
        requestingUsername: requestingUsername,
      );
    } catch (exception) {
      log(exception.toString());
      if (exception is BadRequest) {
        clearPairingCode();
        // statusNotifier.showError(exception.message);
      }
    }
  }

  clearPairingCode() async {
    for (final index in [0, 1, 2, 3, 4, 5]) {
      _clearCodeAtIndex(index);
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  _clearCodeAtIndex(int index) {
    final codes = [...state.code];
    codes[0] = '';
    emit(state.copyWith(code: codes));
  }
}
