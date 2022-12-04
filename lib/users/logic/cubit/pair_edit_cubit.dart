import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:daisy_too/main.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:users/classes/payloads.dart';
import 'package:web_api/implementation/web_api_http.dart';

part 'pair_edit_state.dart';
part 'pair_edit_cubit.freezed.dart';

class PairEditCubit extends Cubit<PairEditState> {
  PairEditCubit({String? pair})
      : super(PairEditState(
          sentPairingRequest: false,
          sentPairingResponse: false,
          pair: pair ?? '',
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

  clearPairingState() {
    emit(state.copyWith(
      pair: '',
      code: List.generate(6, (_) => ''),
      focusedCellIndex: 0,
    ));
  }

  clearSentRequest() {
    emit(state.copyWith(
      sentPairingRequest: false,
      sentPairingResponse: false,
      code: List.generate(6, (_) => ''),
      focusedCellIndex: 0,
    ));
  }

  sendPairingRequest({
    required String requestingUsername,
  }) async {
    try {
      await users.requestPair(PairRequestData(
        pairUsername: state.pair,
        requestingUsername: requestingUsername,
      ));
      emit(state.copyWith(sentPairingRequest: true));
    } catch (exception) {
      log(exception.toString());
      if (exception is BadRequest) {
        statusNotifier.showError(exception.message);
      }
    }
  }

  sendPairingResponse({
    required String requestingUsername,
  }) async {
    try {
      await users.respondPair(PairingResponseData(
        pairingResponse: state.code.join(''),
        respondingUsername: state.pair,
        requestingUsername: requestingUsername,
      ));
      emit(state.copyWith(sentPairingResponse: true));
    } catch (exception) {
      log(exception.toString());
      if (exception is BadRequest) {
        clearPairingCode();
        statusNotifier.showError(exception.message);
      }
    }
  }

  clearPairingCode() async {
    // TODO doesn't work
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
