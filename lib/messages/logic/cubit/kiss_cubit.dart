import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/logic/services/messaging.dart';
import 'package:daisy_too/messages/models/kiss/kiss.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messaging/interface/message.dart';

part 'kiss_state.dart';
part 'kiss_cubit.freezed.dart';

class KissCubit extends Cubit<KissState> {
  KissCubit() : super(KissState()) {
    messaging.onNotificationReceived
        .where((event) => event is KissData)
        .listen(_receiveKiss);
    messaging.onNotificationTapped
        .where((event) => event.id == Notifications.kiss.index)
        .listen(_sendKissBack);
  }

  sendKiss(Kiss kiss) async {
    await messaging.sendMessage(kiss.toMessage());
    emit(state.copyWith(sentKiss: kiss));
  }

  _receiveKiss(Data data) {
    log('kiss received' + data.toString());
    emit(state.copyWith(receivedKiss: Kiss.fromMessage(data as KissData)));
  }

  clearSentKiss() {
    emit(state.copyWith(sentKiss: null));
  }

  clearReceivedKiss() {
    emit(state.copyWith(receivedKiss: null));
  }

  _sendKissBack(NotificationResponse notificationResponse) {
    final kissData = KissData.fromJson(
      jsonDecode(notificationResponse.payload!),
    );
    final kiss = Kiss.fromMessage(kissData);
    sendKiss(kiss);
  }
}
