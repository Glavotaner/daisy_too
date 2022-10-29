import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  final Notification? notification;
  final Data? data;
  const Message({this.notification, this.data});
  factory Message.fromJson(dynamic json) => _$MessageFromJson(json);
  toJson() => _$MessageToJson(this);
  get isPairingRequest => data?.requestingUsername != null;
  get isPairingResponse => data?.confirmedPair != null;
}

@JsonSerializable()
class Notification {
  final String? title;
  final String? body;
  const Notification({this.title, this.body});
  factory Notification.fromJson(dynamic json) => _$NotificationFromJson(json);
  toJson() => _$NotificationToJson(this);
}

@JsonSerializable()
class Data {
  final String? requestingUsername;
  final String? pairingCode;
  final String? confirmedPair;
  const Data({
    this.requestingUsername,
    this.pairingCode,
    this.confirmedPair,
  });
  factory Data.fromJson(dynamic json) => _$DataFromJson(json);
  toJson() => _$DataToJson(this);
}
