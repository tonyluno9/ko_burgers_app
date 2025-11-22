import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/orders_provider.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Pedidos anteriores")),
      body: orders.isEmpty
          ? const Center(child: Text("Aún no tienes pedidos"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (_, i) {
                final o = orders[i];
                return Card(
                  child: ListTile(
                    title: Text("Orden ${o.id}"),
                    subtitle: Text(
                        "${o.items.length} productos · \$${o.total.toStringAsFixed(2)}"),
                    trailing: Text(
                      "${o.date.day}/${o.date.month}/${o.date.year}",
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
