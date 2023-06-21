class Failure {}

class ServerFailure extends Failure {}

class InternetFailure extends Failure {}

class HttpFailure extends Failure {
  final String message;

  HttpFailure(this.message);
}
