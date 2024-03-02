import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/five_days_data.dart';

part 'five_days_data_model.g.dart';

@JsonSerializable()
class FiveDayDataModel {
  final String? dateTime;
  final int? temp;

  FiveDayDataModel({this.dateTime, this.temp});

  factory FiveDayDataModel.fromJson(Map<String, dynamic> json) =>
      _$FiveDayDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$FiveDayDataModelToJson(this);

  FiveDayData toEntity() {
    return FiveDayData(temp: temp, dateTime: dateTime);
  }
}
