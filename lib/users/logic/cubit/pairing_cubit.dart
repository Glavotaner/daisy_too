import 'dart:developer';

import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/main.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messaging/interface/message.dart';
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
        super(PairingState.initial) {
    messaging.onMessageReceived.listen(_receiveMessagePairingRequest);
    messaging.onMessageTapped.listen(_receiveMessagePairingRequest);
    // TODO dispose
  }

  void _receiveMessagePairingRequest(Message message) {
    if (message.isPairingRequest) {
      receivePairingRequest(message: message);
    }
  }

  requestPair() {
    emit(state.copyWith(pairingRequested: true));
  }

  sendPairingRequest({required String requestingUsername}) async {
    try {
      await _users.requestPair(
        requestingUsername: requestingUsername,
        pairUsername: state.pair,
      );
    } catch (exception) {
      log(exception.toString());
      if (exception is BadRequest) {
        statusNotifier.showError(exception.message);
      }
    }
  }

  sendPairingResponse({required String requestingUsername}) async {
    try {
      await _users.respondPair(
        pairingResponse: state.pairingCode,
        respondingUsername: state.pair,
        requestingUsername: requestingUsername,
      );
    } catch (exception) {
      log(exception.toString());
      if (exception is BadRequest) {
        statusNotifier.showError(exception.message);
      }
    }
  }

  receivePairingRequest({required Message message}) async {
    emit(state.copyWith(
      receivedPairingRequest: message,
      code: message.data!.pairingCode!.split(''),
      pair: message.data!.requestingUsername!,
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
    emit(state.copyWith(
      code: code,
      focusedCellIndex: focusedCellIndex,
    ));
  }

  onCellChange(int index) {
    emit(state.copyWith(focusedCellIndex: index));
  }

  checkReceivedRequestsOnAppResume() async {
    throw UnimplementedError();
  }
}
