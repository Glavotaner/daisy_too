import 'package:bloc/bloc.dart';
import 'package:daisy_too/messages/models/kiss/kiss.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kiss_state.dart';
part 'kiss_cubit.freezed.dart';

class KissCubit extends Cubit<KissState> {
  KissCubit() : super(KissState.initial);

  sendKiss(Kiss kiss) {
    emit(state.copyWith(sentKiss: kiss));
  }

  receiveKiss(Kiss kiss) {
    emit(state.copyWith(receivedKiss: kiss));
  }
}
