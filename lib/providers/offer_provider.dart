import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../services/offer_service.dart';

final offersProvider = FutureProvider<List<Post>>((ref) {
  return OfferService.loadOffers();
});
