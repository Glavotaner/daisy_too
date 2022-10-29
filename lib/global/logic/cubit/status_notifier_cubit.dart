import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_notifier_state.dart';
part 'status_notifier_cubit.freezed.dart';

class StatusNotifierCubit extends Cubit<StatusNotifierState> {
  StatusNotifierCubit() : super(const StatusNotifierState());

  showInfo(String message) {
    emitMessage(message: message);
  }

  showSuccess(String message) {
    emitMessage(message: message, color: Colors.greenAccent);
  }

  showError(String message) {
    emitMessage(message: message, color: Colors.redAccent);
  }

  void emitMessage({
    required String message,
    Color? color,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.blueAccent,
    );
    emit(state.copyWith(snackBar: snackBar));
  }
}
