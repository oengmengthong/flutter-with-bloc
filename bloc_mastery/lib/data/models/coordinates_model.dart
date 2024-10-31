// lib/data/models/coordinates_model.dart

import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/coordinates.dart';

part 'coordinates_model.g.dart';

@JsonSerializable()
class CoordinatesModel {
  final double lat;
  final double lng;

  const CoordinatesModel({
    required this.lat,
    required this.lng,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);

  Coordinates toEntity() {
    return Coordinates(
      lat: lat,
      lng: lng,
    );
  }
}