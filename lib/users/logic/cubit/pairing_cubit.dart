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
    messaging.onMessageReceived.listen(_receiveMessagePairingRequest);
    messaging.onMessageTapped.listen(_receiveMessagePairingRequest);
  }

  void _receiveMessagePairingRequest(RemoteMessage remoteMessage) {
    final message = remoteMessage.message;
    var data = message.data;
    // TODO repeated 4
    if (data is PairingRequestData) {
      log('pairing request received');
      receivePairingRequest(message: data);
    } else if (data is PairingResponseData) {
      receivePairingResponse(message: data);
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

  checkReceivedRequestsOnAppResume() async {
    throw UnimplementedError();
  }
}
