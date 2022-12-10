import 'package:json_annotation/json_annotation.dart';
import 'package:messaging/interface/message.dart';

part 'kiss.g.dart';

@JsonSerializable()
class Kiss implements Data {
  const Kiss({
    required this.type,
    this.imageFile,
    this.customMessage,
  });

  Kiss.fromRequest(String request)
      : type = 'Kiss request',
        imageFile = 'request.png',
        customMessage = request;
  Kiss.fromMessage(KissData message)
      : type = message.kissType,
        customMessage = message.localMessage,
        imageFile = message.image;

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
        data: KissData(
          kissType: type,
          image: imageFile,
          localMessage: customMessage,
        ),
      );

  String? get assetPath =>
      imageFile == null ? null : 'assets/kisses/$imageFile';

  @override
  toJson() => _$KissToJson(this);
}
