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
  final String? channel;
  const Message({this.notification, this.data, this.channel});
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class PairingRequestData implements Data, StoredData {
  final String requestingUsername;
  final String pairingCode;
  PairingRequestData({
    required this.requestingUsername,
    required this.pairingCode,
  }) : storageKey = MessageStorageKeys.pairingRequest;
  factory PairingRequestData.fromJson(dynamic json) =>
      _$PairingRequestDataFromJson(json)
        ..storageKey = MessageStorageKeys.pairingRequest;
  @override
  Map<String, dynamic> toJson() => _$PairingRequestDataToJson(this);
  @override
  @JsonKey(ignore: true)
  String storageKey;
}

@JsonSerializable()
class PairingResponseData implements Data, StoredData {
  final String confirmedPair;
  PairingResponseData({required this.confirmedPair})
      : storageKey = MessageStorageKeys.pairingResponse;
  factory PairingResponseData.fromJson(dynamic json) =>
      _$PairingResponseDataFromJson(json)
        ..storageKey = MessageStorageKeys.pairingResponse;
  @override
  Map<String, dynamic> toJson() => _$PairingResponseDataToJson(this);
  @override
  @JsonKey(ignore: true)
  String storageKey;
}

@JsonSerializable()
class KissData implements Data {
  final String kissType;
  final String localMessage;
  final String? image;
  const KissData({
    required this.kissType,
    this.image,
    String? localMessage,
  }) : localMessage = localMessage ?? kissType;
  factory KissData.fromJson(dynamic json) => _$KissDataFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$KissDataToJson(this);
}

abstract class Data {
  factory Data.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('pairingCode')) {
      return PairingRequestData.fromJson(json);
    } else if (json.containsKey('confirmedPair')) {
      return PairingResponseData.fromJson(json);
    } else {
      return KissData.fromJson(json);
    }
  }
  Map<String, dynamic> toJson();
}

abstract class StoredData {
  abstract String storageKey;
}

class MessageStorageKeys {
  static const pairingRequest = 'pairingRequest';
  static const pairingResponse = 'pairingResponse';
}
