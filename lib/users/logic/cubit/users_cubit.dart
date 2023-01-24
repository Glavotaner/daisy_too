import 'dart:developer';

import 'package:daisy_too/main.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users/classes/payloads.dart';
import 'package:users/users.dart';
import 'package:web_api/implementation/web_api_http.dart';
part 'users_cubit.freezed.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final Users users;
  static const _userStorageKey = 'user';
  static const _userOnboardedStorageKey = 'userOnboarded';
  static const _pairStorageKey = 'pair';

  UsersCubit({
    required this.users,
  }) : super(UsersState.initial());

  static isOnboarded(BuildContext context) {
    return context.select((UsersCubit cubit) {
      return cubit.state.isOnboarded ?? false;
    });
  }

  checkUser() async {
    await Future.delayed(const Duration(seconds: 2));
    _refreshToken();
    final registeredUser = sharedPreferences.getString(_userStorageKey);
    if (registeredUser != null) {
      final pair = sharedPreferences.getString(_pairStorageKey);
      _logUser('stored pair ' + (pair ?? 'none'));
      final isOnboarded = sharedPreferences.getBool(_userOnboardedStorageKey);
      if (pair != null) {
        messaging.setPair(pair);
      }
      emit(state.copyWith(
        isRegistered: true,
        isOnboarded: isOnboarded ?? false,
        username: registeredUser,
        pair: pair ?? '',
      ));
    } else {
      emit(state.copyWith(isOnboarded: false));
    }
  }

  registerUser() async {
    try {
      emit(state.copyWith(isRegistering: true));
      await users.register(RegistrationData(
        username: state.username,
        token: state.token,
      ));
      await sharedPreferences.setString(_userStorageKey, state.username);
      emit(state.copyWith(isRegistered: true));
    } catch (exception) {
      log(exception.toString());
      String message = exception is BadRequest
          ? exception.message
          : exception is ServerError
              ? exception.message
              : 'Somefin went wrong!';
      statusNotifier.showError(message);
    } finally {
      emit(state.copyWith(isRegistering: false));
    }
  }

  savePair({required String pair}) async {
    _logUser('pair saved ' + pair);
    await sharedPreferences.setString(_pairStorageKey, pair);
    messaging.setPair(pair);
    emit(state.copyWith(pair: pair));
  }

  onboardUser() async {
    await sharedPreferences.setBool(_userOnboardedStorageKey, true);
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
