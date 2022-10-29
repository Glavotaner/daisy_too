// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kiss.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kiss _$KissFromJson(Map<String, dynamic> json) => Kiss(
      type: json['type'] as String,
      imageFile: json['imageFile'] as String?,
      customMessage: json['customMessage'] as String?,
    );

Map<String, dynamic> _$KissToJson(Kiss instance) => <String, dynamic>{
      'type': instance.type,
      'imageFile': instance.imageFile,
      'customMessage': instance.customMessage,
    };
