// lib/presentation/pages/product_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_event.dart';
import '../blocs/product/product_state.dart';
import 'product_form_page.dart';
class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadProductDetail(productId: productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final state = context.read<ProductBloc>().state;
              if (state is ProductDetailLoaded) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductFormPage(product: state.product),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<ProductBloc>().add(DeleteProduct(productId));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading || state is ProductInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailLoaded) {
            final product = state.product;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title.isNotEmpty
                        ? product.title
                        : 'No Title Available',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  if (product.images.isNotEmpty)
                    SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Image.network(product.images[index]),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 16.0),
                  Text(product.description),
                  // Add more details as needed
                ],
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Product not found'));
          }
        },
      ),
    );
  }
}