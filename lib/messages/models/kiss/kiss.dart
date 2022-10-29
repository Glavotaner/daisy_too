import 'package:json_annotation/json_annotation.dart';

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

  // get message => Message(
  //       notification: Notification(title: type, body: customMessage ?? type),
  //       data: {'kiss': toJson()},
  //     );

  String? get assetPath =>
      imageFile == null ? null : 'assets/kisses/$imageFile';

  toJson() => _$KissToJson(this);
}
