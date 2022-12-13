import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:challenge_fudo/src/features/posts/ui/widgets/post_card.dart';
import 'package:challenge_fudo/src/features/theme/ui/widgets/theme_mode_switch.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class PostsLoadedView extends StatelessWidget {
  const PostsLoadedView({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomColors.black,
      appBar: AppBar(
        title: const Text("Posts"),
        actions: const [
          ThemeModeSwitch(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => kVerticalDivider,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(post: post);
        },
      ),
    );
  }
}
