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
                      decoration: const InputDecoration(labelText: "Dirección"),
                      validator: (v) => v == null || v.isEmpty
                          ? "Ingresa tu dirección"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Seleccione su método de pago",
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
                      onChanged: (v) {
                          setState(() => _method = v!);

                          if (v == "transfer") {
                            _showTransferModal(context);
                          }
                        }),
                    RadioListTile<String>(
                        title: const Text("Tarjeta"),
                        value: "card",
                        groupValue: _method,
                        onChanged: (v) {
                          setState(() => _method = v!);

                          if (v == "card") {
                           _showCardModal(context);
                          }
                        }),
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

                          ref.read(ordersProvider.notifier).addOrder(order);
                          ref.read(userProvider.notifier).addSpent(order.total);
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

  //Modales

  void _showTransferModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pago por Transferencia"),
          content: const Text(
            "Banco: BBVA\n"
            "Cuenta: 5204507867985643\n"
            "CLABE: 012345678901234567\n"
            "Nombre: KO_Burguers (Persona moral)\n"
            "Le peimos de favor enviar el comprobante a:\n"
            "KO_Burguers@gmail.com"
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Aceptar"),
            )
          ],
        );
      },
    );
  }

  void _showCardModal(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final cvvCtrl = TextEditingController();

  Future<void> _selectExpiryDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 15),
    );

    if (picked != null) {
      dateCtrl.text = "${picked.month.toString().padLeft(2, '0')}/${picked.year % 100}";
    }
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Pagar con Tarjeta"),
        content: Form(
          key: _formKey,
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Nombre del titular"),
                  validator: (v) => v!.isEmpty ? "Campo obligatorio" : null,
                ),

                // tarjeta
                TextFormField(
                  controller: numberCtrl,
                  decoration: const InputDecoration(labelText: "Número de tarjeta"),
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Campo obligatorio";
                    if (v.length != 16) return "Debe tener 16 dígitos";
                    return null;
                  },
                ),

                // fecha
                TextFormField(
                  controller: dateCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: "Vencimiento (MM/AA)"),
                  onTap: _selectExpiryDate,
                  validator: (v) => v!.isEmpty ? "Campo obligatorio" : null,
                ),

                // cvv
                TextFormField(
                  controller: cvvCtrl,
                  decoration: const InputDecoration(labelText: "CVV"),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Campo obligatorio";
                    if (v.length != 3) return "Debe tener 3 dígitos";
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
              }
            },
            child: const Text("Guardar método de pago"),
          )
        ],
      );
    },
  );
}

}
