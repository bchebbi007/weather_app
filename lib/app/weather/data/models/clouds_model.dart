
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/clouds.dart';

part 'clouds_model.g.dart';
@JsonSerializable()
class CloudsModel {
  final int? all;

  CloudsModel({this.all});


  factory CloudsModel.fromJson(Map<String, dynamic> json) =>
      _$CloudsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsModelToJson(this);

  // Convert CloudsModel toEntity
  Clouds toEntity(){
    return Clouds(
        all: all
    );
  }

}



