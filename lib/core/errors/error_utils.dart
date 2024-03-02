import 'dart:convert';
import 'package:flutter/cupertino.dart';


import 'exception/http_exceptions.dart';
import 'failure/failures.dart';
import 'package:http/http.dart' as http;


class ErrorUtils {
  /// Takes a http [Response] and returns Json Object or Throws a http Exception
  static dynamic getResponseOrThrowHttpException(http.Response response) {
    debugPrint(
        'getResponseOrThrowHttpException response.body is : ${response.body}');

    debugPrint('response.body is : ${json.decode(response.body)}');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw HttpResponseException(
        statusCode: response.statusCode.toString() ?? '',
        message: response.reasonPhrase ?? '',
      );
    }
  }

  /// Converts [HttpResponseException] and returns a [HttpResponseFailure]
  static HttpResponseFailure mapHttpExceptionToFailure(
      HttpResponseException exception) {
    debugPrint('exception is : $exception');
    switch (exception.statusCode) {
      case "401":
        return HttpResponseFailure(
          HttpResponseFailureType.invalidApiKey,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "404":
        return HttpResponseFailure(
          HttpResponseFailureType.notFound,
          exception.message,
          errorCode: exception.statusCode,
        );
      default:
        return HttpResponseFailure(
          HttpResponseFailureType.unknown,
          exception.message,
          errorCode: exception.statusCode,
        );
    }
  }
}
