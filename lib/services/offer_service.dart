import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/post_model.dart';

class OfferService {
  static Future<List<Post>> loadOffers() async {
    final data = await rootBundle.loadString('assets/data/offers.json');
    final jsonList = json.decode(data) as List;
    return jsonList.map((e) => Post.fromJson(e)).toList();
  }
}
