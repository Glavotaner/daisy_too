import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/types/providers.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_value/key_value.dart';
import 'package:messaging/interface/message.dart';
import 'package:messaging/messaging.dart';
import '../../extensions/message_x.dart';

part 'messages_cubit.freezed.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessageState> {
  final Messaging messaging;
  final KeyValueStorage keyValueStorage;
  final StatusNotifierCubit statusNotifier;
  bool _processingMessage = false;

  MessagesCubit({
    required this.messaging,
    required this.keyValueStorage,
    required this.statusNotifier,
  }) : super(MessageState.initial);

  static sendToPair(
    BuildContext context, {
    required Message message,
  }) {
    context.read<MessagesProvider>().sendMessage(
          message: message,
          to: context.read<UsersProvider>().state.pair,
        );
  }

  init() {
    _registerNotificationChannels();
    _setUpMessageHandlers();
  }

  void _setUpMessageHandlers() {
    FirebaseMessaging.onMessage.listen(_processForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_processTappedMessage);
    FirebaseMessaging.onBackgroundMessage(processBackgroundMessage);
  }

  void _registerNotificationChannels() {
    const pairingNotificationChannel = fln.AndroidNotificationChannel(
      'pairing',
      'Pairing',
      description: 'Pairing requests and responses',
    );
    const kissesNotificationChannel = fln.AndroidNotificationChannel(
      'kisses',
      'Kisses',
      description: 'Received kisses',
    );
    fln.FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<
        fln.AndroidFlutterLocalNotificationsPlugin>()
      ?..createNotificationChannel(pairingNotificationChannel)
      ..createNotificationChannel(kissesNotificationChannel);
  }

  sendMessage({required Message message, required String to}) async {
    emit(state.copyWith(sending: true));
    try {
      await messaging.send(message: state.sentMessage!, to: to);
    } catch (exception) {
      if (exception is SocketException) {
        statusNotifier.showError(exception.message);
      }
    } finally {
      emit(state.copyWith(sending: false));
    }
  }

  checkReceivedRequestsOnAppResume() async {
    await _processMessage(() async {
      final message = await _getStoredMessage();
      if (message != null) {
        emit(state.copyWith(
          receivedMessage: Message.fromJson(
            jsonDecode(message),
          ),
        ));
      }
    });
  }

  _getStoredMessage() async {
    // reload prefs cache on app return from background
    await keyValueStorage.implementation.reload();
    final message = await keyValueStorage.get<String>(key: 'pairing');
    return message == null ? null : Message.fromJson(jsonDecode(message));
  }

  _clearStoredMessage() async {
    return keyValueStorage.remove(key: 'pairing');
  }

  _processForegroundMessage(RemoteMessage remoteMessage) {
    log('data ${jsonEncode(remoteMessage.data)}');
    log('from ${remoteMessage.from}');
    log('category ${remoteMessage.category}');
    log('ca ${remoteMessage.contentAvailable}');
    log('type ${remoteMessage.messageType}');
    log('sender id ${remoteMessage.senderId}');
    emit(state.copyWith(receivedMessage: remoteMessage.message));
  }

  _processTappedMessage(RemoteMessage remoteMessage) async {
    await _processMessage(() async {
      final message = remoteMessage.message;
      if (message.isPairingRequest) {
        final storedPairingMessage = await _getStoredMessage();
        if (storedPairingMessage != null) {
          await _clearStoredMessage();
        }
      }
    });
    _processForegroundMessage(remoteMessage);
  }

  _processMessage(Function messageProcessor) async {
    if (!_processingMessage) {
      _processingMessage = true;
      try {
        await messageProcessor();
      } finally {
        _processingMessage = false;
      }
    }
  }
}

Future<void> processBackgroundMessage(RemoteMessage remoteMessage) async {
  final message = remoteMessage.message;
  if (message.isPairingRequest) {
    final storage = await KeyValueStorageSharedPrefs.instance;
    storage.set<String>(
      key: 'pairing',
      value: jsonEncode(message.toJson()),
    );
  }
}
