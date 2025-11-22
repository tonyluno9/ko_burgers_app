class Product {
  final String name;
  final String image;
  final double price;
  final String description;
  final String category;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        image: json["image"],
        price: (json["price"] as num).toDouble(),
        description: json["description"],
        category: json["category"] ?? "burgers",
      );
}
