import './response.dart';

abstract class WebApi {
  Future<Response> post(
    String url, {
    required Map<String, dynamic> body,
    Map<String, String> headers,
  });
}
