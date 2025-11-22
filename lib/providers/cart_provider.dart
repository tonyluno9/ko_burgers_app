import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/product_model.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addProduct(Product product) {
    final index = state.indexWhere((c) => c.product.name == product.name);
    if (index == -1) {
      state = [...state, CartItem(product: product, quantity: 1)];
    } else {
      final items = [...state];
      items[index].quantity++;
      state = items;
    }
  }

  void removeProduct(Product product) {
    final index = state.indexWhere((c) => c.product.name == product.name);
    if (index == -1) return;
    final items = [...state];
    if (items[index].quantity > 1) {
      items[index].quantity--;
    } else {
      items.removeAt(index);
    }
    state = items;
  }

  void clear() => state = [];

  double get subtotal =>
      state.fold(0, (previous, element) => previous + element.total);

  double get shipping => subtotal >= 250 ? 0 : (state.isEmpty ? 0 : 35);

  double get total => subtotal + shipping;
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
