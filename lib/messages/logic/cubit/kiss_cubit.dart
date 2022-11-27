import 'package:bloc/bloc.dart';
import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/models/kiss/kiss.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kiss_state.dart';
part 'kiss_cubit.freezed.dart';

class KissCubit extends Cubit<KissState> {
  KissCubit() : super(KissState.initial) {
    messaging.onMessageReceived.listen((message) {
      // TODO receive
      // receiveKiss(message.kiss);
    });
    messaging.onMessageTapped.listen((message) {
      // TODO receive
      // receiveKiss(message.kiss);
    });
  }

  sendKiss(Kiss kiss) async {
    // TODO send kiss
    // await messaging.sendMessage(kiss);
    emit(state.copyWith(sentKiss: kiss));
  }

  receiveKiss(Kiss kiss) {
    emit(state.copyWith(receivedKiss: kiss));
  }
}
