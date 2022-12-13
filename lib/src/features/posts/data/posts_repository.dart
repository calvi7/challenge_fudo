import 'dart:convert';

import 'package:challenge_fudo/src/features/posts/data/posts_service.dart';
import 'package:challenge_fudo/src/features/posts/domain/post.dart';

class PostsRepository {
  PostsRepository(this._service);

  final PostsService _service;

  Future<List<Post>> getPosts() async {
    final response = await _service.getPosts();
    final decoded = jsonDecode(response);
    final posts = List<Post>.from(decoded.map((e) => Post.fromMap(e)));
    return posts;
  }

  Future<Post> getPost(int id) async {
    final response = await _service.getPost(id);
    return Post.fromJson(response);
  }
}
