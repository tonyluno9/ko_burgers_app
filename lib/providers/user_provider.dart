import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';

class UserNotifier extends StateNotifier<UserProfile> {
  UserNotifier()
      : super(UserProfile(name: "", address: "", totalSpent: 0));

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateAddress(String address) {
    state = state.copyWith(address: address);
  }

  void addSpent(double amount) {
    state = state.copyWith(totalSpent: state.totalSpent + amount);
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserProfile>((ref) {
  return UserNotifier();
});
