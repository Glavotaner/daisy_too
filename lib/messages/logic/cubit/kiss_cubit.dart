import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/extensions/message_x.dart';
import 'package:daisy_too/messages/models/kiss/kiss.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messaging/interface/message.dart';

part 'kiss_state.dart';
part 'kiss_cubit.freezed.dart';

class KissCubit extends Cubit<KissState> {
  KissCubit() : super(KissState.initial) {
    messaging.onMessageReceived.listen(_receiveKiss);
    messaging.onMessageTapped.listen(_receiveKiss);
  }

  sendKiss(Kiss kiss) async {
    await messaging.sendMessage(kiss.message);
    emit(state.copyWith(sentKiss: kiss));
  }

  _receiveKiss(RemoteMessage remoteMessage) {
    final message = remoteMessage.message;
    var data = message.data;
    if (data is KissData) {
      log('kiss received' + data.toString());
      emit(state.copyWith(receivedKiss: Kiss.fromMessage(data)));
    }
  }

  clearSentKiss() {
    emit(state.copyWith(sentKiss: null));
  }

  clearReceivedKiss() {
    emit(state.copyWith(receivedKiss: null));
  }
}
