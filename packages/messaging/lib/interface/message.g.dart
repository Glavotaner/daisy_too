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
      channel: json['channel'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'notification': instance.notification,
      'data': instance.data,
      'channel': instance.channel,
    };

PairingRequestData _$PairingRequestDataFromJson(Map<String, dynamic> json) =>
    PairingRequestData(
      requestingUsername: json['requestingUsername'] as String,
      pairingCode: json['pairingCode'] as String,
    );

Map<String, dynamic> _$PairingRequestDataToJson(PairingRequestData instance) =>
    <String, dynamic>{
      'requestingUsername': instance.requestingUsername,
      'pairingCode': instance.pairingCode,
    };

PairingResponseData _$PairingResponseDataFromJson(Map<String, dynamic> json) =>
    PairingResponseData(
      confirmedPair: json['confirmedPair'] as String,
    );

Map<String, dynamic> _$PairingResponseDataToJson(
        PairingResponseData instance) =>
    <String, dynamic>{
      'confirmedPair': instance.confirmedPair,
    };

KissData _$KissDataFromJson(Map<String, dynamic> json) => KissData(
      kissType: json['kissType'] as String,
      image: json['image'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$KissDataToJson(KissData instance) => <String, dynamic>{
      'kissType': instance.kissType,
      'message': instance.message,
      'image': instance.image,
    };
