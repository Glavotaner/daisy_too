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
      data = Data.fromJson(this.data);
    }
    return Message(notification: notification, data: data);
  }

  bool get isKiss {
    return data.containsKey('kissType');
  }
}
