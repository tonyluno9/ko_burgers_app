class OffersModel {
  final String name;
  final String image;
  final double price;
  final String description;
  final String category;

  OffersModel({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
        name: json["name"],
        image: json["image"],
        price: (json["price"] as num).toDouble(),
        description: json["description"],
        category: json["category"] ?? "offer",
      );
}
