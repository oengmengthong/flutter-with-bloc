// lib/data/repositories/product_repository_impl.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';
import 'auth_repository_impl.dart';

class ProductRepositoryImpl implements ProductRepository {
  final http.Client client;
  final AuthRepositoryImpl authRepository;

  ProductRepositoryImpl({
    http.Client? client,
    required this.authRepository,
  }) : client = client ?? http.Client();

  @override
  Future<List<Product>> fetchProducts({int limit = 30, int skip = 0}) async {
    final token = await authRepository.getAccessToken();
    final response = await client.get(
      Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> productsJson = jsonResponse['products'];
      final products = productsJson
          .map((json) => ProductModel.fromJson(json).toEntity())
          .toList();
      return products;
    } else if (response.statusCode == 401) {
      // Unauthorized, try refreshing the token
      await authRepository.refreshToken();
      return fetchProducts(limit: limit, skip: skip); // Retry after refreshing
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    final token = await authRepository.getAccessToken();
    final response = await client.get(
      Uri.parse('https://dummyjson.com/products/$id'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final productModel = ProductModel.fromJson(json.decode(response.body));
      return productModel.toEntity();
    } else if (response.statusCode == 401) {
      await authRepository.refreshToken();
      return getProductById(id);
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  @override
  Future<Product> addProduct(Product product) async {
    final token = await authRepository.getAccessToken();
    final response = await client.post(
      Uri.parse('https://dummyjson.com/products/add'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(ProductModel.fromEntity(product).toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final productModel = ProductModel.fromJson(json.decode(response.body));
      return productModel.toEntity();
    } else if (response.statusCode == 401) {
      await authRepository.refreshToken();
      return addProduct(product);
    } else {
      throw Exception('Failed to add product');
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final token = await authRepository.getAccessToken();
    final response = await client.put(
      Uri.parse('https://dummyjson.com/products/${product.id}'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(ProductModel.fromEntity(product).toJson()),
    );

    if (response.statusCode == 200) {
      final productModel = ProductModel.fromJson(json.decode(response.body));
      return productModel.toEntity();
    } else if (response.statusCode == 401) {
      await authRepository.refreshToken();
      return updateProduct(product);
    } else {
      throw Exception('Failed to update product');
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final token = await authRepository.getAccessToken();
    final response = await client.delete(
      Uri.parse('https://dummyjson.com/products/$id'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      await authRepository.refreshToken();
      return deleteProduct(id);
    } else {
      throw Exception('Failed to delete product');
    }
  }
}