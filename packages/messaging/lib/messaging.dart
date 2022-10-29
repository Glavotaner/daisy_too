library messaging;

import 'package:messaging/interface/message.dart';
import 'package:web_api/interface/web_api.dart';

class Messaging {
  final WebApi api;
  final String appUrl = 'http://10.0.2.2:3000/api/';
  const Messaging({
    required this.api,
});

  Future<void> send({required Message message, required String to}) {
    return api.post('${appUrl}messaging/send', body: {
      'message': message.toJson(), 'to': to
    });
  }
}
