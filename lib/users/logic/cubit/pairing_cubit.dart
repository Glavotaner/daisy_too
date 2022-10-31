import 'dart:developer';

import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/types/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:users/users.dart';
import 'package:web_api/implementation/web_api_http.dart';

part 'pairing_cubit.freezed.dart';
part 'pairing_state.dart';

class PairingCubit extends Cubit<PairingState> {
  final Users _users;
  final StatusNotifierCubit statusNotifier;
  PairingCubit({
    required Users users,
    required this.statusNotifier,
  })  : _users = users,
        super(PairingState.initial);

  static bool pairingRequested(BuildContext context) {
    return context.select((PairingProvider cubit) {
      return cubit.state.requestSent;
    });
  }

  static String inputPair(BuildContext context) {
    return context.select((PairingProvider cubit) {
      return cubit.state.pair;
    });
  }

  static bool pairingRequestReceived(BuildContext context) {
    return context.select((PairingProvider cubit) {
      return cubit.state.requestReceived;
    });
  }

  static String pairingCode(BuildContext context) {
    return context.select((PairingProvider cubit) {
      return cubit.state.pairingCode;
    });
  }

  requestPairing() {
    log('pairing requested');
    emit(state.copyWith(pairingRequested: true));
  }

  sendPairingRequest({
    required String requestingUsername,
  }) async {
    try {
      await _users.requestPair(
        requestingUsername: requestingUsername,
        pairUsername: state.pair,
      );
      emit(state.copyWith(requestSent: true));
    } catch (exception) {
      log(exception.toString());
      if (exception is BadRequest) {
        statusNotifier.showError(exception.message);
      }
    }
  }

  sendPairingResponse() async {
    try {
      emit(state.copyWith(responseSent: true));
    } catch (exception) {
      log(exception.toString());
      if (exception is BadRequest) {
        statusNotifier.showError(exception.message);
      }
    }
  }

  receivePairingRequest({
    required String pair,
    required String pairingCode,
  }) async {
    emit(state.copyWith(
      requestReceived: true,
      code: pairingCode.split(''),
      pair: pair,
    ));
  }

  clearPairingState() {
    emit(PairingState.initial);
  }

  copyPairingCode() async {
    await Clipboard.setData(
      ClipboardData(text: state.pairingCode),
    );
  }

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
    emit(
      state.copyWith(
        code: code,
        focusedCellIndex: focusedCellIndex,
      ),
    );
  }

  onCellChange(int index) {
    emit(state.copyWith(focusedCellIndex: index));
  }
}
