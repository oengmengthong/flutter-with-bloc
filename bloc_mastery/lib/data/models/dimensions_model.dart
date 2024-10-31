// lib/data/models/dimensions_model.dart

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/dimensions.dart';

part 'dimensions_model.g.dart';

@JsonSerializable()
class DimensionsModel {
  final double? width;
  final double? height;
  final double? depth;

  const DimensionsModel({
    this.width,
    this.height,
    this.depth,
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json) =>
      _$DimensionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsModelToJson(this);

  Dimensions toEntity() {
    return Dimensions(
      width: width ?? 0.0,
      height: height ?? 0.0,
      depth: depth ?? 0.0,
    );
  }

  factory DimensionsModel.fromEntity(Dimensions dimensions) {
    return DimensionsModel(
      width: dimensions.width,
      height: dimensions.height,
      depth: dimensions.depth,
    );
  }
}