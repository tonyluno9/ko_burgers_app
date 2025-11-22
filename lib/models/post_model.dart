class Post {
  final String title;
  final String description;
  final String date;
  final String image;

  Post({
    required this.title,
    required this.description,
    required this.date,
    required this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json["title"],
        description: json["description"],
        date: json["date"],
        image: json["image"],
      );
}
