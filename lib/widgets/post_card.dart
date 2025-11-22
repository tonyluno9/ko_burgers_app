import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(post.image, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(post.date,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Text(post.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
