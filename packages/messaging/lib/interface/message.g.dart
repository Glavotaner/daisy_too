// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      notification: json['notification'] == null
          ? null
          : Notification.fromJson(json['notification'] as Map<String, dynamic>),
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'notification': instance.notification,
      'data': instance.data,
    };

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      requestingUsername: json['requestingUsername'] as String?,
      pairingCode: json['pairingCode'] as String?,
      confirmedPair: json['confirmedPair'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'requestingUsername': instance.requestingUsername,
      'pairingCode': instance.pairingCode,
      'confirmedPair': instance.confirmedPair,
    };
