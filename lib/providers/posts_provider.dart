import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../services/posts_service.dart';

final postsProvider = FutureProvider<List<Post>>((ref) {
  return PostsService.loadPosts();
});
