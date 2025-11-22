import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_model.dart';

class ProductsService {
  static Future<List<Product>> loadProducts() async {
    final data = await rootBundle.loadString('assets/data/products.json');
    final jsonList = json.decode(data) as List;
    return jsonList.map((e) => Product.fromJson(e)).toList();
  }
}
