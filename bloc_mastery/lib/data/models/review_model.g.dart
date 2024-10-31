// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      reviewerName: json['reviewerName'] as String?,
      reviewerEmail: json['reviewerEmail'] as String?,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'comment': instance.comment,
      'date': instance.date?.toIso8601String(),
      'reviewerName': instance.reviewerName,
      'reviewerEmail': instance.reviewerEmail,
    };
