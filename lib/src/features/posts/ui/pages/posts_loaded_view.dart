import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:challenge_fudo/src/features/posts/ui/pages/post_card.dart';
import 'package:flutter/material.dart';

class PostsLoadedView extends StatelessWidget {
  const PostsLoadedView({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(post: post);
        },
      ),
    );
  }
}
