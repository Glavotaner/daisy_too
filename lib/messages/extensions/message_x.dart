import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:messaging/interface/message.dart';

extension FcmMessages on RemoteMessage {
  Message get message {
    Notification? notification;
    if (this.notification != null) {
      notification = Notification(
        title: this.notification!.title,
        body: this.notification!.body,
      );
    }
    Data? data;
    if (this.data.isNotEmpty) {
      data = Data(
        confirmedPair: this.data['confirmedPair'],
        pairingCode: this.data['pairingCode'],
        requestingUsername: this.data['requestingUsername'],
      );
    }
    return Message(notification: notification, data: data);
  }
}
