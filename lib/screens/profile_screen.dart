import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 12),
            Text(
              user.name.isEmpty ? "Invitado KO" : user.name,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              user.levelLabel,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Dirección"),
              subtitle: Text(
                  user.address.isEmpty ? "Sin dirección guardada" : user.address),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text("Pedidos anteriores"),
              onTap: () => context.push('/orders'),
            ),
            ListTile(
              leading: const Icon(Icons.local_offer_outlined),
              title: const Text("Ofertas y cupones"),
              onTap: () => context.push('/offers'),
            ),
          ],
        ),
      ),
    );
  }
}
