import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreenOffers extends ConsumerWidget {
  final Product product;

  const ProductDetailScreenOffers({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final burgerType = ValueNotifier<String>("Clásica");
    final drinkType = ValueNotifier<String>("Coca");

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

                // selector burguer
                ValueListenableBuilder(
                  valueListenable: burgerType,
                  builder: (_, value, __) {
                    return DropdownButtonFormField<String>(
                      value: value,
                      decoration: const InputDecoration(
                        labelText: "Tipo de Burger",
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: "Clásica", child: Text("Clásica con queso")),
                        DropdownMenuItem(
                            value: "Bufalo", child: Text("Bufalo")),
                        DropdownMenuItem(value: "BBQ", child: Text("BBQ")),
                        DropdownMenuItem(
                            value: "Chesse", child: Text("Chesse")),
                      ],
                      onChanged: (v) => burgerType.value = v!,
                    );
                  },
                ),

                const SizedBox(height: 24),

                // selector bebida
                ValueListenableBuilder(
                  valueListenable: drinkType,
                  builder: (_, value, __) {
                    return DropdownButtonFormField<String>(
                      value: value,
                      decoration: const InputDecoration(
                        labelText: "Tipo de bebida",
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: "Malteada de fresa",
                            child: Text("Malteada de Fresa")),
                        DropdownMenuItem(
                            value: "Malteada de vainilla",
                            child: Text("Malteada de Vainilla")),
                        DropdownMenuItem(
                            value: "Malteada de horchata",
                            child: Text("Malteada de Horchata")),
                        DropdownMenuItem(
                            value: "Coca", 
                            child: Text("Coca-Cola")),
                        DropdownMenuItem(
                          value: "Te", 
                          child: Text("Té negro")),
                      ],
                      onChanged: (v) => drinkType.value = v!,
                    );
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addProduct(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "${product.name} (${burgerType.value}) agregado al carrito"),
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
