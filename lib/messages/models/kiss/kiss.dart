import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:messaging/interface/message.dart';

part 'kiss.g.dart';

@JsonSerializable()
class Kiss {
  const Kiss({
    required this.type,
    this.imageFile,
    this.customMessage,
  });

  Kiss.fromRequest(String request)
      : type = 'Kiss request',
        imageFile = null,
        customMessage = request;
  Kiss.fromMessage(RemoteMessage message)
      : type = message.data['kissType'],
        customMessage = message.data['customMessage'],
        imageFile = message.data['imageFile'];

  factory Kiss.fromJson(Map<String, dynamic> json) => _$KissFromJson(json);

  static const kisses = [
    Kiss(
      type: 'baby kiss',
      imageFile: 'boss-baby.png',
    ),
    Kiss(
      type: 'boss baby kiss',
      imageFile: 'boss-baby.png',
    ),
    Kiss(
      type: 'big kiss',
      imageFile: 'boss-baby.png',
    ),
  ];

  final String type;
  final String? imageFile;
  final String? customMessage;

  get message => Message(
        notification: Notification(title: type, body: customMessage ?? type),
        // TODO data
      );

  String? get assetPath =>
      imageFile == null ? null : 'assets/kisses/$imageFile';

  toJson() => _$KissToJson(this);
}
