import 'dart:async';
import 'dart:developer';

import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/extensions/message_x.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messaging/interface/message.dart';

part 'pairing_cubit.freezed.dart';
part 'pairing_state.dart';

class PairingCubit extends Cubit<PairingState> {
  PairingCubit() : super(PairingState.initial()) {
    messaging.onMessageReceived.listen(_handleReceivedMessage);
    messaging.onMessageTapped.listen(_handleReceivedMessage);
  }

  void handlePotentialPairingMessage(Data messageData) {
    if (messageData is PairingRequestData) {
      _logPairing('request received');
      receivePairingRequest(message: messageData);
      messaging.clearStoredMessage(messageData.storageKey);
    } else if (messageData is PairingResponseData) {
      _logPairing('response received');
      receivePairingResponse(message: messageData);
      messaging.clearStoredMessage(messageData.storageKey);
    }
  }

  void _handleReceivedMessage(RemoteMessage remoteMessage) {
    Data? data = remoteMessage.message.data;
    if (data != null) {
      handlePotentialPairingMessage(data);
    }
  }

  requestPair() {
    emit(state.copyWith(pairingRequested: true));
  }

  receivePairingRequest({required PairingRequestData message}) {
    emit(state.copyWith(receivedPairingRequest: message));
  }

  receivePairingResponse({required PairingResponseData message}) {
    emit(state.copyWith(receivedPairingResponse: message));
  }

  clearRequestedPairing() {
    emit(state.copyWith(pairingRequested: false));
  }

  clearMessages() {
    emit(state.copyWith(
      receivedPairingResponse: null,
      receivedPairingRequest: null,
    ));
  }

  copyPairingCode([String? code]) async {
    await Clipboard.setData(
      ClipboardData(text: code ?? state.receivedPairingRequest!.pairingCode),
    );
  }

  handleMessagesOnAppResume() async {
    // wait in case pairing message was opened via notification tap
    await Future.delayed(const Duration(milliseconds: 250));
    final data = await messaging.getStoredMessage();
    if (data != null) {
      handlePotentialPairingMessage(data as Data);
    }
  }

  _logPairing(String message) {
    log(message, name: 'pairing');
  }
}
