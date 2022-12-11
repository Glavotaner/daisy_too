import 'dart:developer';

import 'package:daisy_too/main.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_value/key_value.dart';
import 'package:users/classes/payloads.dart';
import 'package:users/users.dart';
import 'package:web_api/implementation/web_api_http.dart';
part 'users_cubit.freezed.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final KeyValueStorage keyValueStorage;
  final Users users;

  UsersCubit({
    required this.keyValueStorage,
    required this.users,
  }) : super(UsersState.initial);

  static isOnboarded(BuildContext context) {
    return context.select((UsersCubit cubit) {
      return cubit.state.isOnboarded ?? false;
    });
  }

  checkUser() async {
    await Future.delayed(const Duration(seconds: 1));
    _refreshToken();
    final registeredUser = await keyValueStorage.get<String>(key: 'user');
    if (registeredUser != null) {
      final storedData = await Future.wait([
        keyValueStorage.get<String>(key: 'pair'),
        keyValueStorage.get<bool>(key: 'userOnboarded'),
      ]);
      final pair = storedData[0] as String?;
      _logUser('stored pair ' + (pair ?? 'none'));
      final isOnboarded = storedData[1] as bool?;
      if (pair != null) {
        messaging.setPair(pair);
      }
      emit(state.copyWith(
        isRegistered: true,
        username: registeredUser,
        pair: pair ?? '',
        isOnboarded: isOnboarded ?? false,
      ));
    } else {
      emit(state.copyWith(isOnboarded: false));
    }
  }

  registerUser() async {
    try {
      await users.register(RegistrationData(
        username: state.username,
        token: state.token,
      ));
      await keyValueStorage.set<String>(key: 'user', value: state.username);
      emit(state.copyWith(isRegistered: true));
    } catch (exception) {
      log(exception.toString());
      String message = exception is BadRequest
          ? exception.message
          : exception is ServerError
              ? exception.message
              : 'Somefin went wrong!';
      statusNotifier.showError(message);
    }
  }

  savePair({required String pair}) async {
    _logUser('pair saved ' + pair);
    await keyValueStorage.set<String>(key: 'pair', value: pair);
    messaging.setPair(pair);
    emit(state.copyWith(pair: pair));
  }

  onboardUser() async {
    await keyValueStorage.set<bool>(key: 'userOnboarded', value: true);
    emit(state.copyWith(isOnboarded: true));
  }

  onUsernameChange(String username) {
    emit(state.copyWith(username: username));
  }

  _refreshToken() async {
    final token = await messaging.getToken();
    _logUser('new token ' + (token ?? 'none'));
    emit(state.copyWith(token: token!));
  }

  _logUser(String message) {
    log(message, name: 'user');
  }
}
