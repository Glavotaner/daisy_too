import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:daisy_too/messages/extensions/message_x.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;
import 'package:messaging/interface/message.dart';
import 'package:messaging/messaging.dart';

import '../../../main.dart';

class MessagingService {
  final Messaging messaging;
  final _onActionNotificationTapped =
      StreamController<fln.NotificationResponse>.broadcast();
  late final Stream<fln.NotificationResponse> onNotificationTapped;
  final _onActionNotificationReceived = StreamController<Data>.broadcast();
  late final Stream<Data> onNotificationReceived;
  String? _pair;

  MessagingService({required this.messaging}) {
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
    final json = {
      'id': details.id,
      'actionId': details.actionId,
      'payload': details.payload,
      'notificationResponseType': details.notificationResponseType.index,
    };
    await sharedPreferences.setString(
      details.actionId ?? details.id.toString(),
      jsonEncode(json),
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
    await sharedPreferences.reload();
    final messages = await _getMessages();
    return _getDataOfType<PairingRequestData>(messages) ??
        _getDataOfType<PairingResponseData>(messages);
  }

  StoredData? _getDataOfType<T>(List<StoredData> data) {
    final dataIndex = data.indexWhere((m) => m is T);
    return dataIndex > -1 ? data[dataIndex] : null;
  }

  Future<List<StoredData>> _getMessages() async {
    final messages = [
      sharedPreferences.getString(MessageStorageKeys.pairingRequest),
      sharedPreferences.getString(MessageStorageKeys.pairingResponse),
    ];
    return messages
        .where((m) => m != null)
        .map((m) => Data.fromJson(jsonDecode(m!)) as StoredData)
        .toList();
  }

  clearStoredMessage(String storageKey) async {
    return sharedPreferences.remove(storageKey);
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
    await sharedPreferences.reload();
    final actionMessages = [
      sharedPreferences.getString(
        Notifications.kiss.index.toString(),
      ),
      sharedPreferences.getString(
        Notifications.pairingRequest.index.toString(),
      ),
    ];
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
        sharedPreferences.remove(response.actionId ?? response.id.toString());
      }
    }
  }
}

Future<void> processBackgroundMessage(RemoteMessage remoteMessage) async {
  final data = remoteMessage.message.data;
  log("Messaging: Received ${data.runtimeType}");
  if (data is PairingResponseData) {
    sharedPreferences.setString(data.storageKey, jsonEncode(data.toJson()));
  } else if (data is PairingRequestData) {
    _showPairingRequestNotification(data);
  } else if (data is KissData) {
    _showKissNotification(data);
  }
}

void _showPairingRequestNotification(PairingRequestData data) {
  const pairingRequestAction = fln.AndroidNotificationAction(
    'copyCode',
    'Copy pairing code',
    showsUserInterface: true,
  );
  _showNotification(
    id: Notifications.pairingRequest,
    title: 'Pairing request',
    body: '${data.requestingUsername} wants to pair with you!',
    payload: jsonEncode(data.toJson()),
    channel: const Channel.kisses(),
    action: pairingRequestAction,
  );
}

void _showKissNotification(KissData data) {
  const kissNotificationAction = fln.AndroidNotificationAction(
    'sendBacc',
    'Send kiss bacc',
    showsUserInterface: true,
  );
  _showNotification(
    id: Notifications.kiss,
    title: data.kissType,
    body: data.message,
    payload: jsonEncode(data.toJson()),
    channel: const Channel.kisses(),
    action: kissNotificationAction,
  );
}

_showNotification({
  required Notifications id,
  required String title,
  required String body,
  required String payload,
  required Channel channel,
  required fln.AndroidNotificationAction action,
}) {
  final details = fln.NotificationDetails(
    android: fln.AndroidNotificationDetails(
      channel.id,
      channel.name,
      actions: [action],
    ),
  );
  fln.FlutterLocalNotificationsPlugin().show(
    id.index,
    title,
    body,
    details,
    payload: payload,
  );
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
