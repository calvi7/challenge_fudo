import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:challenge_fudo/src/utils/colors.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: CustomColors.lightPurple,
      borderRadius: BorderRadius.circular(20),
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Card(
        elevation: 20,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: decoration,
              child: Center(
                child: Text(
                  "${post.id}",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            title: Text(
              post.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              post.body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
