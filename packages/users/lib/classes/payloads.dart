import 'package:users/users.dart';

class RegistrationData implements Jsonable {
  final String username;
  final String token;

  const RegistrationData({
    required this.username,
    required this.token,
  });

  @override
  toJson() => {
        'username': username,
        'token': token,
      };
}

class PairRequestData implements Jsonable {
  final String requestingUsername;
  final String pairUsername;

  const PairRequestData({
    required this.requestingUsername,
    required this.pairUsername,
  });

  @override
  toJson() => {
        'requestingUsername': requestingUsername,
        'pairUsername': pairUsername,
      };
}

class PairingResponseData implements Jsonable {
  final String requestingUsername;
  final String respondingUsername;
  final String pairingResponse;

  const PairingResponseData({
    required this.requestingUsername,
    required this.respondingUsername,
    required this.pairingResponse,
  });

  @override
  toJson() => {
        'requestingUsername': requestingUsername,
        'respondingUsername': respondingUsername,
        'pairingResponse': pairingResponse,
      };
}
