class HttpException implements Exception {
  final message;
  final prefix;

  HttpException(this.message, this.prefix);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends HttpException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends HttpException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends HttpException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends HttpException {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}