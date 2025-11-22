import 'cart_item.dart';

class Order {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double total;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
  });
}
