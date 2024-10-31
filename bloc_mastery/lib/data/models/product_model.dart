// lib/data/models/product_model.dart

import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/dimensions.dart';
import '../../domain/entities/meta.dart';
import '../../domain/entities/product.dart';
import 'dimensions_model.dart';
import 'meta_model.dart';
import 'review_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final double? weight;
  final DimensionsModel? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewModel>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final MetaModel? meta;
  final String? thumbnail;
  final List<String>? images;

  const ProductModel({
    required this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.thumbnail,
    this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  Product toEntity() {
    return Product(
      id: id,
      title: title ?? '',
      description: description ?? '',
      category: category ?? '',
      price: price ?? 0.0,
      discountPercentage: discountPercentage ?? 0.0,
      rating: rating ?? 0.0,
      stock: stock ?? 0,
      tags: tags ?? [],
      brand: brand ?? '',
      sku: sku ?? '',
      weight: weight ?? 0.0,
      dimensions: dimensions?.toEntity() ?? Dimensions(width: 0, height: 0, depth: 0),
      warrantyInformation: warrantyInformation ?? '',
      shippingInformation: shippingInformation ?? '',
      availabilityStatus: availabilityStatus ?? '',
      reviews: reviews?.map((e) => e.toEntity()).toList() ?? [],
      returnPolicy: returnPolicy ?? '',
      minimumOrderQuantity: minimumOrderQuantity ?? 0,
      meta: meta?.toEntity() ?? Meta(createdAt: DateTime.now(), updatedAt: DateTime.now(), barcode: '', qrCode: ''),
      thumbnail: thumbnail ?? '',
      images: images ?? [],
    );
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      category: product.category,
      price: product.price,
      discountPercentage: product.discountPercentage,
      rating: product.rating,
      stock: product.stock,
      tags: product.tags,
      brand: product.brand,
      sku: product.sku,
      weight: product.weight,
      dimensions: DimensionsModel.fromEntity(product.dimensions),
      warrantyInformation: product.warrantyInformation,
      shippingInformation: product.shippingInformation,
      availabilityStatus: product.availabilityStatus,
      reviews: product.reviews.map((e) => ReviewModel.fromEntity(e)).toList(),
      returnPolicy: product.returnPolicy,
      minimumOrderQuantity: product.minimumOrderQuantity,
      meta: MetaModel.fromEntity(product.meta),
      thumbnail: product.thumbnail,
      images: product.images,
    );
  }
}