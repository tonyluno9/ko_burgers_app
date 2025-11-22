import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/post_model.dart';

class PostsService {
  static Future<List<Post>> loadPosts() async {
    final data = await rootBundle.loadString('assets/data/posts.json');
    final jsonList = json.decode(data) as List;
    return jsonList.map((e) => Post.fromJson(e)).toList();
  }
}
