import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ko_burgers_app/screens/product_detail_screen_offers.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/bottom_nav.dart';

// 👇 Agregado SOLO esto
import '../screens/product_detail_screen_burguers.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  String _category = "burgers";

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú KO Burgers"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => context.push('/cart'),
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      cart.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
      bottomNavigationBar: const BottomNav(index: 1),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildCategorySelector(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: productsAsync.when(
                data: (list) {
                  final filtered = list.where((p) => p.category == _category).toList();
                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final product = filtered[i];

                      return ProductCard(
                        product: product,


                        onTap: () {
                          if (_category == "burgers") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreenBurguers(product: product),
                              ),
                            );
                          }
                          if (_category == 'offer') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreenOffers(product: product),
                              ),
                            );
                          }
                        },

                        onAdd: () {
                          ref.read(cartProvider.notifier).addProduct(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("${product.name} agregado al carrito"),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Center(child: Text("Error al cargar menú")),
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildCategorySelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _catChip("🍔 Burgers", "burgers"),
            const SizedBox(width: 8),
            _catChip("🍟 Papas", "fries"),
            const SizedBox(width: 8),
            _catChip("🍰 Postres", "desserts"),
            const SizedBox(width: 8),
            _catChip("🥤 Bebidas", "drinks"),
            const SizedBox(width: 8),
            _catChip("🕑 Ofertas", "offer"),
          ],
        ),
      ),
    );
  }


  Widget _catChip(String label, String value) {
    final selected = _category == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          _category = value;
        });
      },
    );
  }
}
