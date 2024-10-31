// lib/presentation/blocs/product/product_state.dart

import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductDetailLoaded extends ProductState {
  final Product product;

  const ProductDetailLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

class ProductAdded extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductUpdated extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductDeleted extends ProductState {
  final int productId;

  const ProductDeleted({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}