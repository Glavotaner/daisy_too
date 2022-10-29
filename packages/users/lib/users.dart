library users;

import 'package:users/classes/endpoints.dart';
import 'package:web_api/interface/web_api.dart';

class Users {
  static const String appUrl = 'http://10.0.2.2:3000/api/';
  final WebApi api;

  const Users({required this.api});

  register({
    required String username,
    required String token,
  }) {
    return _callApi(Endpoints.register, body: {
      'username': username,
      'token': token,
    });
  }

  requestPair({
    required String requestingUsername,
    required String pairUsername,
  }) {
    return _callApi(Endpoints.requestPair, body: {
      'requestingUsername': requestingUsername,
      'pairUsername': pairUsername,
    });
  }

  respondPair({
    required String requestingUsername,
    required String respondingUsername,
    required String pairingResponse,
  }) {
    return _callApi(Endpoints.respondPair, body: {
      'requestingUsername': requestingUsername,
      'respondingUsername': respondingUsername,
      'pairingResponse': pairingResponse,
    });
  }

  Future<void> _callApi(String endpoint, {required Map<String, dynamic> body}) {
    return api.post('${appUrl}user/$endpoint', body: body);
  }
}
