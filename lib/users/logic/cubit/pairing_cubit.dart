import 'dart:developer';

import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/extensions/message_x.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
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

  sendPairingRequest({
    required String requestingUsername,
    required String pair,
  }) async {
    try {
      await _users.requestPair(
        requestingUsername: requestingUsername,
        pairUsername: pair,
      );
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
    required String pairingCode,
    required String pair,
  }) async {
    try {
      await _users.respondPair(
        pairingResponse: pairingCode,
        respondingUsername: pair,
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
    emit(state.copyWith(receivedPairingRequest: message));
  }

  clearSentRequest() {
    emit(state.copyWith(sentPairingRequest: false));
  }

  clearRequestedPairing() {
    emit(state.copyWith(pairingRequested: false));
  }

  checkReceivedRequestsOnAppResume() async {
    throw UnimplementedError();
  }
}
