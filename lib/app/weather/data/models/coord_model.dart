import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/coord.dart';

part 'coord_model.g.dart';

@JsonSerializable()
class CoordModel {
  final double? lon;
  final double? lat;

  CoordModel({this.lon, this.lat});

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      _$CoordModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordModelToJson(this);



  Coord toEntity(){
    return Coord(
        lat: lat,
      lon: lon
    );
  }
}
