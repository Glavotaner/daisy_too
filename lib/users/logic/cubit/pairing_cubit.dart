import 'dart:developer';

import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/extensions/message_x.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messaging/interface/message.dart';

part 'pairing_cubit.freezed.dart';
part 'pairing_state.dart';

class PairingCubit extends Cubit<PairingState> {
  PairingCubit() : super(PairingState.initial) {
    messaging.onMessageReceived.listen(_receiveMessagePairingRequest);
    messaging.onMessageTapped.listen(_receiveMessagePairingRequest);
  }

  void _receiveMessagePairingRequest(RemoteMessage remoteMessage) {
    final message = remoteMessage.message;
    if (message.isPairingRequest) {
      log('pairing request received');
      receivePairingRequest(message: message);
    }
  }

  requestPair() {
    emit(state.copyWith(pairingRequested: true));
  }

  receivePairingRequest({required Message message}) async {
    emit(state.copyWith(receivedPairingRequest: message));
  }

  clearRequestedPairing() {
    emit(state.copyWith(pairingRequested: false));
  }

  checkReceivedRequestsOnAppResume() async {
    throw UnimplementedError();
  }
}
