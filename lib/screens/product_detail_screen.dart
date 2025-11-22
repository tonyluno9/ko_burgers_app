import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Hero(
            tag: product.name,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                product.image,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(product.description),
                const SizedBox(height: 16),
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .addProduct(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "${product.name} agregado al carrito"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text("Agregar al carrito"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
