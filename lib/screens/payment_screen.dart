import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';
import '../providers/user_provider.dart';
import '../models/order_model.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  String _method = "efectivo";

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final cart = ref.watch(cartProvider);

    _nameCtrl.text = ref.watch(userProvider).name;
    _addressCtrl.text = ref.watch(userProvider).address;

    return Scaffold(
      appBar: AppBar(title: const Text("Pago")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: cart.isEmpty
            ? const Center(child: Text("Carrito vacío."))
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      "Datos del usuario",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameCtrl,
                      decoration:
                          const InputDecoration(labelText: "Nombre completo"),
                      validator: (v) =>
                          v == null || v.isEmpty ? "Ingresa tu nombre" : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _addressCtrl,
                      decoration:
                          const InputDecoration(labelText: "Dirección"),
                      validator: (v) =>
                          v == null || v.isEmpty ? "Ingresa tu dirección" : null,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Método de pago (mock)",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    RadioListTile<String>(
                      title: const Text("Efectivo"),
                      value: "efectivo",
                      groupValue: _method,
                      onChanged: (v) => setState(() => _method = v!),
                    ),
                    RadioListTile<String>(
                      title: const Text("Transferencia"),
                      value: "transfer",
                      groupValue: _method,
                      onChanged: (v) => setState(() => _method = v!),
                    ),
                    RadioListTile<String>(
                      title: const Text("Tarjeta (solo UI)"),
                      value: "card",
                      groupValue: _method,
                      onChanged: (v) => setState(() => _method = v!),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Resumen",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        "Total a pagar: \$${cartNotifier.total.toStringAsFixed(2)}"),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          ref
                              .read(userProvider.notifier)
                              .updateName(_nameCtrl.text.trim());
                          ref
                              .read(userProvider.notifier)
                              .updateAddress(_addressCtrl.text.trim());

                          final orderId =
                              "KO-${Random().nextInt(999999).toString().padLeft(6, '0')}";
                          final order = Order(
                            id: orderId,
                            date: DateTime.now(),
                            items: List.from(cart),
                            subtotal: cartNotifier.subtotal,
                            shipping: cartNotifier.shipping,
                            total: cartNotifier.total,
                          );

                          ref
                              .read(ordersProvider.notifier)
                              .addOrder(order);
                          ref
                              .read(userProvider.notifier)
                              .addSpent(order.total);
                          ref.read(cartProvider.notifier).clear();

                          context.go('/success', extra: orderId);
                        },
                        child: const Text("Pagar ahora"),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
