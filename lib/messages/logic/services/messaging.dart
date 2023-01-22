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
  final _onActionNotificationTapped =
      StreamController<fln.NotificationResponse>.broadcast();
  late final Stream<fln.NotificationResponse> onNotificationTapped;
  final _onActionNotificationReceived = StreamController<Data>.broadcast();
  late final Stream<Data> onNotificationReceived;
  String? _pair;

  MessagingService({required this.messaging, required this.keyValueStorage}) {
    _registerNotificationChannels();
    _setUpMessageHandlers();
    onNotificationTapped = _onActionNotificationTapped.stream;
    onNotificationReceived = _onActionNotificationReceived.stream;
    FirebaseMessaging.onMessage.listen((event) {
      _onActionNotificationReceived.add(Data.fromJson(event.data));
    });
  }

  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  void notifyTappedMessage(fln.NotificationResponse notificationResponse) {
    if (notificationResponse.notificationResponseType ==
        fln.NotificationResponseType.selectedNotificationAction) {
      _onActionNotificationTapped.add(notificationResponse);
    } else {
      _onActionNotificationReceived.add(
        Data.fromJson(jsonDecode(notificationResponse.payload!)),
      );
    }
  }

  @pragma('vm:entry-point')
  static onBackgroundNotificationTap(fln.NotificationResponse details) async {
    final preferences = await KeyValueStorageSharedPrefs.instance;
    await preferences.set(
      key: details.actionId ?? details.id.toString(),
      value: jsonEncode(details.toJson()),
    );
  }

  void _setUpMessageHandlers() {
    FirebaseMessaging.onMessage.listen(_processForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_processForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(processBackgroundMessage);
    fln.FlutterLocalNotificationsPlugin().initialize(
      const fln.InitializationSettings(
        android: fln.AndroidInitializationSettings('ic_notification'),
      ),
      onDidReceiveBackgroundNotificationResponse: onBackgroundNotificationTap,
      onDidReceiveNotificationResponse: notifyTappedMessage,
    );
  }

  void _registerNotificationChannels() {
    const pairing = Channel.pairing();
    const kisses = Channel.kisses();
    final pairingNotificationChannel = fln.AndroidNotificationChannel(
      pairing.id,
      pairing.name,
      description: 'Pairing requests and responses',
    );
    final kissesNotificationChannel = fln.AndroidNotificationChannel(
      kisses.id,
      kisses.name,
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

  Future<StoredData?> getStoredMessage() async {
    // reload prefs cache on app return from background
    await keyValueStorage.implementation.reload();
    final messages = await _getMessages();
    return _getDataOfType<PairingRequestData>(messages) ??
        _getDataOfType<PairingResponseData>(messages);
  }

  StoredData? _getDataOfType<T>(List<StoredData> data) {
    final dataIndex = data.indexWhere((m) => m is T);
    return dataIndex > -1 ? data[dataIndex] : null;
  }

  Future<List<StoredData>> _getMessages() async {
    final messages = await Future.wait([
      keyValueStorage.get<String>(key: MessageStorageKeys.pairingRequest),
      keyValueStorage.get<String>(key: MessageStorageKeys.pairingResponse),
    ]);
    return messages
        .where((m) => m != null)
        .map((m) => Data.fromJson(jsonDecode(m!)) as StoredData)
        .toList();
  }

  clearStoredMessage(String storageKey) async {
    return keyValueStorage.remove(key: storageKey);
  }

  _processForegroundMessage(RemoteMessage remoteMessage) {
    log('data ${jsonEncode(remoteMessage.data)}');
    log('from ${remoteMessage.from}');
    log('category ${remoteMessage.category}');
    log('ca ${remoteMessage.contentAvailable}');
    log('type ${remoteMessage.messageType}');
    log('sender id ${remoteMessage.senderId}');
  }

  void handleBackgroundNotificationActions() async {
    final preferences = await KeyValueStorageSharedPrefs.instance;
    await preferences.implementation.reload();
    final actionMessages = await Future.wait([
      preferences.get<String>(
        key: Notifications.kiss.index.toString(),
      ),
      preferences.get<String>(
        key: Notifications.pairingRequest.index.toString(),
      ),
    ]);
    for (String? message in actionMessages) {
      if (message != null) {
        final messageJson = jsonDecode(message);
        final response = fln.NotificationResponse(
          id: messageJson['id'],
          actionId: messageJson['actionId'],
          payload: messageJson['payload'],
          notificationResponseType: fln.NotificationResponseType
              .values[messageJson['notificationResponseType']],
        );
        notifyTappedMessage(response);
        preferences.remove(key: response.actionId ?? response.id.toString());
      }
    }
  }
}

Future<void> processBackgroundMessage(RemoteMessage remoteMessage) async {
  final data = remoteMessage.message.data;
  if (data is StoredData) {
    final storage = await KeyValueStorageSharedPrefs.instance;
    storage.set<String>(
      key: (data as StoredData).storageKey,
      value: jsonEncode(data!.toJson()),
    );
  }
  if (data is PairingRequestData) {
    _showPairingRequestNotification(data);
  } else if (data is KissData) {
    _showKissNotification(data);
  }
}

void _showPairingRequestNotification(PairingRequestData data) {
  const channel = Channel.pairing();
  const pairingRequestAction = fln.AndroidNotificationAction(
    'copyCode',
    'Copy pairing code',
    showsUserInterface: true,
  );
  final details = fln.NotificationDetails(
    android: fln.AndroidNotificationDetails(
      channel.id,
      channel.name,
      actions: [pairingRequestAction],
    ),
  );
  fln.FlutterLocalNotificationsPlugin().show(
    Notifications.pairingRequest.index,
    'Pairing request',
    '${data.requestingUsername} wants to pair with you!',
    details,
    payload: jsonEncode(data.toJson()),
  );
}

void _showKissNotification(KissData data) {
  const channel = Channel.kisses();
  const kissNotificationAction = fln.AndroidNotificationAction(
    'sendBacc',
    'Send kiss bacc',
    showsUserInterface: true,
  );
  final details = fln.NotificationDetails(
    android: fln.AndroidNotificationDetails(
      channel.id,
      channel.name,
      actions: [kissNotificationAction],
    ),
  );
  fln.FlutterLocalNotificationsPlugin().show(
    Notifications.kiss.index,
    data.kissType,
    data.message,
    details,
    payload: jsonEncode(data.toJson()),
  );
}

extension DaisyNotificationResponse on fln.NotificationResponse {
  toJson() {
    return {
      'id': id,
      'actionId': actionId,
      'payload': payload,
      'notificationResponseType': notificationResponseType.index,
    };
  }
}

class NoPairException {
  final String message = "Pair not set!";
}

class Channel {
  final String id;
  final String name;
  const Channel(this.id, this.name);
  const Channel.pairing()
      : id = 'pairing',
        name = 'Pairing';
  const Channel.kisses()
      : id = 'kisses',
        name = 'Kisses';
}

enum Notifications {
  pairingRequest,
  kiss,
}
