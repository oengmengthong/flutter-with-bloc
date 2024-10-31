// lib/data/models/review_model.dart

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/review.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final int? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  const ReviewModel({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  Review toEntity() {
    return Review(
      rating: rating ?? 0,
      comment: comment ?? '',
      date: date ?? DateTime.now(),
      reviewerName: reviewerName ?? '',
      reviewerEmail: reviewerEmail ?? '',
    );
  }

  factory ReviewModel.fromEntity(Review review) {
    return ReviewModel(
      rating: review.rating,
      comment: review.comment,
      date: review.date,
      reviewerName: review.reviewerName,
      reviewerEmail: review.reviewerEmail,
    );
  }
}