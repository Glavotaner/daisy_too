import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/logic/services/messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messaging/interface/message.dart';

part 'pairing_cubit.freezed.dart';
part 'pairing_state.dart';

class PairingCubit extends Cubit<PairingState> {
  PairingCubit() : super(PairingState.initial()) {
    messaging.onNotificationReceived.where((event) {
      return event is PairingRequestData || event is PairingResponseData;
    }).listen(handlePotentialPairingMessage);
    messaging.onNotificationTapped
        .where((event) => event.id == Notifications.pairingRequest.index)
        .listen(_copyPairingCode);
  }

  _copyPairingCode(NotificationResponse notificationResponse) {
    final PairingRequestData request = Data.fromJson(
      jsonDecode(notificationResponse.payload!),
    ) as PairingRequestData;
    copyPairingCode(request.pairingCode);
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
