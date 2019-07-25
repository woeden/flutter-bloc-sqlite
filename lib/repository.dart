import 'dart:async';
import 'package:test_bloc/providers/post_provider.dart';

import 'models/post.dart';

class Repository {
  final postProvider = PostsProvider();

  Future<List<Post>> fetchAllPosts() => postProvider.getPosts();
}