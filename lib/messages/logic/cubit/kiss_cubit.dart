import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/extensions/message_x.dart';
import 'package:daisy_too/messages/models/kiss/kiss.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kiss_state.dart';
part 'kiss_cubit.freezed.dart';

class KissCubit extends Cubit<KissState> {
  KissCubit() : super(KissState.initial) {
    messaging.onMessageReceived.listen((message) {
      if (message.isKiss) {
        log('kiss received');
        _receiveKiss(Kiss.fromMessage(message));
      }
    });
    messaging.onMessageTapped.listen((message) {
      if (message.isKiss) {
        _receiveKiss(Kiss.fromMessage(message));
      }
    });
  }

  sendKiss(Kiss kiss) async {
    await messaging.sendMessage(kiss.message);
    emit(state.copyWith(sentKiss: kiss));
  }

  _receiveKiss(Kiss kiss) {
    emit(state.copyWith(receivedKiss: kiss));
  }
}
