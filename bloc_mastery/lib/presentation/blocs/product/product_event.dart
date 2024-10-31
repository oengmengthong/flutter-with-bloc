// lib/presentation/blocs/product/product_event.dart

import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProducts extends ProductEvent {
  final int limit;
  final int skip;

  const LoadProducts({this.limit = 30, this.skip = 0});

  @override
  List<Object> get props => [limit, skip];
}

class LoadProductDetail extends ProductEvent {
  final int productId;

  const LoadProductDetail({required this.productId});

  @override
  List<Object> get props => [productId];
}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final Product product;

  const UpdateProduct(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final int productId;

  const DeleteProduct(this.productId);

  @override
  List<Object> get props => [productId];
}