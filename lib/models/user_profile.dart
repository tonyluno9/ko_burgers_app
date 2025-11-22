class UserProfile {
  final String name;
  final String address;
  final double totalSpent;

  UserProfile({
    required this.name,
    required this.address,
    required this.totalSpent,
  });

  UserProfile copyWith({
    String? name,
    String? address,
    double? totalSpent,
  }) {
    return UserProfile(
      name: name ?? this.name,
      address: address ?? this.address,
      totalSpent: totalSpent ?? this.totalSpent,
    );
  }

  String get levelLabel {
    if (totalSpent >= 3000) return "LVL 3 • Campeón KO";
    if (totalSpent >= 1500) return "LVL 2 • Guerrero";
    if (totalSpent > 0) return "LVL 1 • Rookie";
    return "Sin nivel aún";
  }
}
