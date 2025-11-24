import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final orderId = state.extra as String? ?? "KO-000000";

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle,
                  color: Colors.green, size: 120),
              const SizedBox(height: 20),
              const Text(
                "¡Pedido confirmado!",
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("Orden: $orderId"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.push('/orders'),
                child: const Text("Ver comprobante"),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.go('/home'),
                child: const Text("Volver al inicio"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
