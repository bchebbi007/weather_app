

import 'failure.dart';

enum GeneralFailureType {
  unexpectedError,
  internetConnectionError,
  formatError,
  noSuchMethodError,
  platformError,
  socketException,
  uploadFile,
  handshake,
  InternetConnectionError,
  dowloandFileFail


}

enum StripeFailureType {
  stripeExeption
}

enum PermissionCheckFailureType {
  permissionDenied,
  unknown
}

enum LocationFailureType {
  timeout,
  locationServiceDisabled,
  platformException
}


enum HttpResponseFailureType {
  invalidApiKey,
  notFound,
  unknown,
}



/// General failure
class GeneralFailure extends Failure {
    GeneralFailure(GeneralFailureType type, String description, {errorCode })
      : super(type, description, errorCode );
}

/// permission failure
///
class PermissionCheckFailure extends Failure {
  PermissionCheckFailure(PermissionCheckFailureType type, String description, {errorCode })
      : super(type, description, errorCode );
}

class LocationFailure extends Failure {
  LocationFailure(LocationFailureType type, String description, {errorCode })
      : super(type, description, errorCode);
}

class HttpResponseFailure extends Failure {
  HttpResponseFailure(HttpResponseFailureType type, description, {errorCode})
      : super(type, description, errorCode);
}
