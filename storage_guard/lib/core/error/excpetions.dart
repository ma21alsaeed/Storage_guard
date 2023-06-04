class ServerException implements Exception {}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
