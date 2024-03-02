// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'five_days_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiveDayDataModel _$FiveDayDataModelFromJson(Map<String, dynamic> json) =>
    FiveDayDataModel(
      dateTime: json['dateTime'] as String?,
      temp: json['temp'] as int?,
    );

Map<String, dynamic> _$FiveDayDataModelToJson(FiveDayDataModel instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime,
      'temp': instance.temp,
    };
