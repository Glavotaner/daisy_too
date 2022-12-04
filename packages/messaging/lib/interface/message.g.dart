// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      notification: json['notification'] == null
          ? null
          : Notification.fromJson(json['notification']),
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'notification': instance.notification,
      'data': instance.data,
    };

Map<String, dynamic> _$PairingRequestDataToJson(PairingRequestData instance) =>
    <String, dynamic>{
      'requestingUsername': instance.requestingUsername,
      'pairingCode': instance.pairingCode,
    };

Map<String, dynamic> _$PairingResponseDataToJson(
        PairingResponseData instance) =>
    <String, dynamic>{
      'confirmedPair': instance.confirmedPair,
    };
