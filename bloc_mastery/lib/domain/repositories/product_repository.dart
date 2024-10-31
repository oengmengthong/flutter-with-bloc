// lib/domain/repositories/product_repository.dart

import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts({int limit = 30, int skip = 0});
  Future<Product> getProductById(int id);
  Future<Product> addProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<void> deleteProduct(int id);
}