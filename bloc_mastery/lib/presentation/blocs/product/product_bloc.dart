// lib/presentation/blocs/product/product_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  List<Product> products = [];

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductDetail>(_onLoadProductDetail);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      products = await productRepository.fetchProducts(
        limit: event.limit,
        skip: event.skip,
      );
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onLoadProductDetail(
      LoadProductDetail event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product = await productRepository.getProductById(event.productId);
      emit(ProductDetailLoaded(product: product));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onAddProduct(
      AddProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final newProduct = await productRepository.addProduct(event.product);
      products.add(newProduct);
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final updatedProduct = await productRepository.updateProduct(event.product);
      final index = products.indexWhere((p) => p.id == updatedProduct.id);
      if (index != -1) {
        products[index] = updatedProduct;
      }
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await productRepository.deleteProduct(event.productId);
      products.removeWhere((product) => product.id == event.productId);
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}