import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Notification {
  final String? title;
  final String? body;
  const Notification({this.title, this.body});
  factory Notification.fromJson(dynamic json) => _$NotificationFromJson(json);
  toJson() => _$NotificationToJson(this);
}

@JsonSerializable()
class Message {
  final Notification? notification;
  final Data? data;
  const Message({this.notification, this.data});
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  toJson() => _$MessageToJson(this);
}

@JsonSerializable(createFactory: false)
class PairingRequestData implements Data {
  final String requestingUsername;
  final String pairingCode;
  const PairingRequestData({
    required this.requestingUsername,
    required this.pairingCode,
  });
  @override
  Map<String, dynamic> toJson() => _$PairingRequestDataToJson(this);
}

@JsonSerializable(createFactory: false)
class PairingResponseData implements Data {
  final String confirmedPair;
  const PairingResponseData({required this.confirmedPair});
  @override
  Map<String, dynamic> toJson() => _$PairingResponseDataToJson(this);
}

abstract class Data {
  factory Data.fromJson(Map<String, dynamic> json) {
    final pairingCode = json['pairingCode'];
    final confirmedPair = json['confirmedPair'];
    if (pairingCode != null) {
      final requestingUsername = json['requestingUsername'];
      return PairingRequestData(
        requestingUsername: requestingUsername,
        pairingCode: pairingCode,
      );
    } else {
      return PairingResponseData(confirmedPair: confirmedPair);
    }
  }
  Map<String, dynamic> toJson();
}
