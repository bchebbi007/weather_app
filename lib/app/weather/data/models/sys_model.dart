
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/sys.dart';

part 'sys_model.g.dart';

@JsonSerializable()
class SysModel {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  SysModel({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory SysModel.fromJson(Map<String, dynamic> json) =>
      _$SysModelFromJson(json);

  Map<String, dynamic> toJson() => _$SysModelToJson(this);



  Sys toEntity() {
    return Sys(
      type: type,
      id: id,
      country: country,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
