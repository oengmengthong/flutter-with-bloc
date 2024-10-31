// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) =>
    CoordinatesModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
