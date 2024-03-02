/// The exceptions that could happen when using http api
class HttpResponseException implements Exception {
  String statusCode;
  String message;

  HttpResponseException({required this.statusCode,required this.message ,});

  @override
  String toString() {
    return message;
  }
}
/*
class HttpNotModifiedException extends HttpResponseException {
  HttpNotModifiedException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}

class HttpBadRequestException extends HttpResponseException {
  HttpBadRequestException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}

class HttpForbiddenException extends HttpResponseException {
  HttpForbiddenException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}

class HttpUnauthorizedException extends HttpResponseException {
  HttpUnauthorizedException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}

class HttpConflictException extends HttpResponseException {
  HttpConflictException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}

class HttpNotFoundException extends HttpResponseException {
  HttpNotFoundException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}

class HttpInternalServerErrorException extends HttpResponseException {
  HttpInternalServerErrorException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}

class HttpBadGetewayException extends HttpResponseException {
  HttpBadGetewayException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}

class HttpGatewayTimeoutException extends HttpResponseException {
  HttpGatewayTimeoutException(int statusCode, String message)
      : super(statusCode: statusCode, message: message);
}


*/
class HttpUnknownException extends HttpResponseException {
  HttpUnknownException(String statusCode, String message)
      : super(statusCode: statusCode, message: message);
}