import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:daisy_too/messages/extensions/message_x.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;
import 'package:key_value/key_value.dart';
import 'package:messaging/interface/message.dart';
import 'package:messaging/messaging.dart';

class MessagingService {
  final Messaging messaging;
  final KeyValueStorage keyValueStorage;
  String? _pair;

  MessagingService({required this.messaging, required this.keyValueStorage}) {
    _registerNotificationChannels();
    _setUpMessageHandlers();
  }

  Stream<RemoteMessage> get onMessageTapped =>
      FirebaseMessaging.onMessageOpenedApp;
  Stream<RemoteMessage> get onMessageReceived => FirebaseMessaging.onMessage;

  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  void _setUpMessageHandlers() {
    FirebaseMessaging.onMessage.listen(_processForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_processForegroundMessage);
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

  setPair(String pair) {
    _pair = pair;
  }

  sendMessage(Message message) async {
    if (_pair != null) {
      return messaging.send(message: message, to: _pair!);
    } else {
      throw NoPairException();
    }
  }

  Future<Message?> getStoredMessage() async {
    // reload prefs cache on app return from background
    await keyValueStorage.implementation.reload();
    final message = await keyValueStorage.get<String>(key: 'pairing');
    _clearStoredMessage();
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
  }
}

Future<void> processBackgroundMessage(RemoteMessage remoteMessage) async {
  final message = remoteMessage.message;
  if (message.data is PairingRequestData) {
    final storage = await KeyValueStorageSharedPrefs.instance;
    storage.set<String>(
      key: 'pairing',
      value: jsonEncode(message.toJson()),
    );
  }
}

class NoPairException {
  final String message = "Pair not set!";
}
