class Response {
  final String? body;
  final Map<String, String>? headers;
  final num statusCode;
  const Response({required this.statusCode, this.body, this.headers});
}