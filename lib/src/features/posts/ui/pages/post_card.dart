import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple,
        ),
        child: Center(
          child: Text(
            post.id.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: Text(
        post.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        post.body,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
