import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../services/products_service.dart';

final productsProvider = FutureProvider<List<Product>>((ref) {
  return ProductsService.loadProducts();
});
