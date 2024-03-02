import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/app/weather/data/models/current_weather_data_model.dart';
import 'package:weather_app/core/constants/app_const.dart';
import 'package:weather_app/core/services/http_service.dart';
import 'package:weather_app/injection.dart';

import '../../../../core/errors/error_utils.dart';
import '../../../../core/errors/exception/http_exceptions.dart';
import '../../domain/entities/five_days_data.dart';
import '../models/five_days_data_model.dart';

abstract class BaseWeatherDatasource {
  Future<CurrentWeatherDataModel> getCurrentWeatherByCity(
      {required String city});

  Future<CurrentWeatherDataModel> getCurrentWeatherByPosition(
      {required double lat, required double long});

  Future<List<CurrentWeatherDataModel>> getFiveDaysThreeHoursForcastData({required String city});
}

@LazySingleton(as: BaseWeatherDatasource)
class WeatherDatasource extends BaseWeatherDatasource {

  final HttpService _httpService = locator<HttpService>();
  @override
  Future<CurrentWeatherDataModel> getCurrentWeatherByCity(
      {required String city}) async {

    var response;

    try {
      response = await _httpService.getRequest(
         endpoint:'weather?q=$city&lang=fr&appid=$weatherApiKey',
      );
      CurrentWeatherDataModel weather = CurrentWeatherDataModel.fromJson(response);

      return weather;
    } on HttpResponseException catch (e) {
      throw ErrorUtils.mapHttpExceptionToFailure(e);
    }
  }

  @override
  Future<CurrentWeatherDataModel> getCurrentWeatherByPosition(
      {required double lat, required double long}) async{
    var response;

    try {
      response = await _httpService.getRequest(
        endpoint:'onecall?lat=$lat&lon=$long&lang=fr&appid=$weatherApiKey',
      );
      CurrentWeatherDataModel weather = CurrentWeatherDataModel.fromJson(response);

      return weather;
    } on HttpResponseException catch (e) {
      throw ErrorUtils.mapHttpExceptionToFailure(e);
    }
  }

  @override
  Future<List<CurrentWeatherDataModel>> getFiveDaysThreeHoursForcastData({required String city}) async {
    List<CurrentWeatherDataModel> _fiveDaysDataList = List.empty(growable: true);
    var response;

    try {
      response = await _httpService.getRequest(
        endpoint:'forecast?q=$city&lang=fr&appid=$weatherApiKey',
      );
      for(var i = 0 ; i < response['list'].length ; i++){
        CurrentWeatherDataModel data = CurrentWeatherDataModel.fromJson(response['list'][i]);
        _fiveDaysDataList.add(data);
      }


      return _fiveDaysDataList;
    } on HttpResponseException catch (e) {
      throw ErrorUtils.mapHttpExceptionToFailure(e);
    }
  }
}
