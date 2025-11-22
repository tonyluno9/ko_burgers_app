import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../widgets/bottom_nav.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Carrito")),
      bottomNavigationBar: const BottomNav(index: 1),
      body: cart.isEmpty
          ? const Center(child: Text("Tu carrito está vacío"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.length,
                    itemBuilder: (_, i) {
                      final item = cart[i];
                      return Card(
                        child: ListTile(
                          title: Text(item.product.name),
                          subtitle: Text(
                              "\$${item.product.price.toStringAsFixed(2)} x ${item.quantity}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () =>
                                    notifier.removeProduct(item.product),
                              ),
                              Text(item.quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () =>
                                    notifier.addProduct(item.product),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      _row("Subtotal",
                          "\$${notifier.subtotal.toStringAsFixed(2)}"),
                      _row("Envío",
                          notifier.shipping == 0 ? "Gratis" : "\$${notifier.shipping.toStringAsFixed(2)}"),
                      const SizedBox(height: 8),
                      const Divider(),
                      _row(
                        "Total",
                        "\$${notifier.total.toStringAsFixed(2)}",
                        isStrong: true,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.push('/payment'),
                          child: const Text("Proceder al pago"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget _row(String label, String value, {bool isStrong = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight:
                    isStrong ? FontWeight.w600 : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                fontWeight:
                    isStrong ? FontWeight.w700 : FontWeight.normal)),
      ],
    );
  }
}
