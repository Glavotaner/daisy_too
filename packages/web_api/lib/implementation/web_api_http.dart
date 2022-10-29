import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_api/interface/response.dart';
import 'package:web_api/interface/web_api.dart';

class WebApiHttp implements WebApi {
  @override
  post(
    String url, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final httpResponse = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers ?? {'Content-Type': 'application/json'},
    );
    final response = Response(
      statusCode: httpResponse.statusCode,
      headers: httpResponse.headers,
      body: httpResponse.body,
    );
    if (response.statusCode < 300) {
      return response;
    }
    else if (response.statusCode > 399 && response.statusCode < 500) {
      throw BadRequest(response.body ?? 'Somefin went wrong!');
    } {
      throw ServerError(response.body ?? 'Somefin went wrong!');
    }
  }
}

class BadRequest {
  final String message;
  const BadRequest(this.message);
}

class ServerError {
  final String message;
  const ServerError(this.message);
}
