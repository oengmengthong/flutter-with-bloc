// lib/data/models/meta_model.dart

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/meta.dart';

part 'meta_model.g.dart';

@JsonSerializable()
class MetaModel {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? barcode;
  final String? qrCode;

  const MetaModel({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);

  Meta toEntity() {
    return Meta(
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      barcode: barcode ?? '',
      qrCode: qrCode ?? '',
    );
  }

  factory MetaModel.fromEntity(Meta meta) {
    return MetaModel(
      createdAt: meta.createdAt,
      updatedAt: meta.updatedAt,
      barcode: meta.barcode,
      qrCode: meta.qrCode,
    );
  }
}