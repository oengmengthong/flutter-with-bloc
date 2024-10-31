// lib/presentation/pages/product_form_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/dimensions.dart';
import '../../domain/entities/meta.dart';
import '../../domain/entities/product.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_event.dart';
import '../blocs/product/product_state.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;

  const ProductFormPage({super.key, this.product});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    _titleController = TextEditingController(text: product?.title ?? '');
    _descriptionController =
        TextEditingController(text: product?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Product' : 'Add Product'),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductAdded || state is ProductUpdated) {
            Navigator.pop(context);
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                // Add more fields as needed
                const SizedBox(height: 16.0),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(isEditing ? 'Update' : 'Add'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id ?? 0, // The API will assign an ID for new products
        title: _titleController.text,
        description: _descriptionController.text,
        // Set other fields appropriately
        category: 'category',
        price: 0.0,
        discountPercentage: 0.0,
        rating: 0.0,
        stock: 0,
        tags: [],
        brand: 'brand',
        sku: 'sku',
        weight: 0.0,
        dimensions: Dimensions(width: 0, height: 0, depth: 0),
        warrantyInformation: '',
        shippingInformation: '',
        availabilityStatus: '',
        reviews: [],
        returnPolicy: '',
        minimumOrderQuantity: 1,
        meta: Meta(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            barcode: '',
            qrCode: ''),
        thumbnail: '',
        images: [],
      );

      if (widget.product != null) {
        context.read<ProductBloc>().add(UpdateProduct(product));
      } else {
        context.read<ProductBloc>().add(AddProduct(product));
      }
    }
  }
}