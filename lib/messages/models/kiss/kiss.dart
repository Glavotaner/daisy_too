import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messaging/interface/message.dart';

part 'kiss.freezed.dart';
part 'kiss.g.dart';

@freezed
class Kiss with _$Kiss implements Data {
  const Kiss._();
  factory Kiss({
    required String type,
    String? imageFile,
    String? message,
  }) = _Kiss;

  factory Kiss.fromRequest(String request) {
    return Kiss(
      type: 'Kiss request',
      imageFile: 'request.png',
      message: request,
    );
  }

  factory Kiss.fromMessage(KissData message) {
    return Kiss(
      type: message.kissType,
      imageFile: message.image,
      message: message.message,
    );
  }

  factory Kiss.fromJson(Map<String, dynamic> json) => _$KissFromJson(json);

  toMessage() => Message(
        notification: Notification(title: type, body: message ?? type),
        data: KissData(
          kissType: type,
          image: imageFile,
          message: message ?? 'You received kiss!',
        ),
        channel: 'kisses',
      );

  String? get assetPath =>
      imageFile == null ? null : 'assets/kisses/$imageFile';
}
