import 'dart:convert';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;


import '../errors/error_utils.dart';
import '../errors/exception/http_exceptions.dart';

@lazySingleton
class HttpService {

  final httpClient = http.Client();
  final String baseUrl = "https://api.openweathermap.org/data/2.5/";

  HttpService();


  Future<Map<String , dynamic>> getRequest(
      {Map<String, dynamic>? dataToSend,
        bool withHeaders = true,
        required String endpoint}) async {

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*",
      "Access-Control-Allow-Headers":
      "Accept, Origin, Content-Type, X-Auth-Token",
    };

    final Uri url = Uri.parse(baseUrl + endpoint);


    try {
      var response = await httpClient.get(url,
          headers: requestHeaders );
      var responseResult = ErrorUtils.getResponseOrThrowHttpException(response);
      return responseResult;
    } on HttpResponseException catch (e) {
      throw ErrorUtils.mapHttpExceptionToFailure(e);
    }
  }


}
