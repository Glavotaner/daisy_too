library users;

import 'package:users/classes/endpoints.dart';
import 'package:users/classes/payloads.dart';
import 'package:web_api/interface/web_api.dart';

class Users {
  static const String appUrl = 'http://10.0.2.2:3000/api/';
  final WebApi api;

  const Users({required this.api});

  register(RegistrationData data) {
    return _callApi(Endpoints.register, body: data);
  }

  requestPair(PairRequestData data) {
    return _callApi(Endpoints.requestPair, body: data);
  }

  respondPair(PairingResponseData data) {
    return _callApi(Endpoints.respondPair, body: data);
  }

  Future<void> _callApi(String endpoint, {required Jsonable body}) {
    return api.post('${appUrl}user/$endpoint', body: body.toJson());
  }
}

abstract class Jsonable {
  Map<String, dynamic> toJson();
}
