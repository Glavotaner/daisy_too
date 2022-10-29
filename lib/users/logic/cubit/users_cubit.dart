import 'dart:developer';

import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/types/providers.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_value/key_value.dart';
import 'package:users/users.dart';
import 'package:web_api/implementation/web_api_http.dart';
part 'users_cubit.freezed.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final KeyValueStorage keyValueStorage;
  final Users users;
  final StatusNotifierCubit statusNotifier;
  UsersCubit({
    required this.keyValueStorage,
    required this.users,
    required this.statusNotifier,
  }) : super(UsersState.initial);

  static isOnboarded(BuildContext context) {
    return context.select((UsersProvider cubit) {
      return cubit.state.isOnboarded;
    });
  }

  static bool isRegistered(BuildContext context) {
    return context.select((UsersProvider cubit) {
      return cubit.state.isRegistered;
    });
  }

  static bool isPaired(BuildContext context) {
    return context.select((UsersProvider cubit) {
      return cubit.state.hasPair;
    });
  }

  checkUser() async {
    _refreshToken();
    final registeredUser = await keyValueStorage.get<String>(key: 'user');
    if (registeredUser != null) {
      final storedData = await Future.wait([
        keyValueStorage.get<String>(key: 'pair'),
        keyValueStorage.get<bool>(key: 'userOnboarded'),
      ]);
      final pair = storedData[0] as String?;
      final isOnboarded = storedData[1] as bool?;
      emit(state.copyWith(
        isRegistered: true,
        username: registeredUser,
        pair: pair ?? '',
        isOnboarded: isOnboarded ?? false,
      ));
    }
  }

  registerUser() async {
    try {
      final username = state.username;
      await users.register(username: username, token: state.token);
      await keyValueStorage.set<String>(key: 'user', value: username);
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
    log('pair saved');
    await keyValueStorage.set<String>(key: 'pair', value: pair);
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
    final token = await FirebaseMessaging.instance.getToken();
    log('new token');
    emit(state.copyWith(token: token!));
  }
}
