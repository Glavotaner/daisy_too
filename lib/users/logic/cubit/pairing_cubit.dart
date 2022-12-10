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
  PairingCubit() : super(PairingState.initial) {
    messaging.onMessageReceived.listen(_handleReceivedMessage);
    messaging.onMessageTapped.listen(_handleReceivedMessage);
  }

  void handlePotentialPairingMessage(Data messageData) {
    if (messageData is PairingRequestData) {
      _logPairing('request received');
      receivePairingRequest(message: messageData);
    } else if (messageData is PairingResponseData) {
      _logPairing('response received');
      receivePairingResponse(message: messageData);
    }
    messaging.clearStoredMessage((messageData as StoredData).storageKey);
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

  receivePairingRequest({required PairingRequestData message}) async {
    emit(state.copyWith(receivedPairingRequest: message));
  }

  receivePairingResponse({required PairingResponseData message}) async {
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

  copyPairingCode() async {
    await Clipboard.setData(
      ClipboardData(
        text: state.receivedPairingRequest!.pairingCode,
      ),
    );
  }

  _logPairing(String message) {
    log(message, name: 'pairing');
  }
}
