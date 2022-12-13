import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:challenge_fudo/src/features/posts/ui/widgets/post_card.dart';
import 'package:challenge_fudo/src/shared_widgets/app_end_drawer.dart';
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
      ),
      endDrawer: const AppEndDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: Center(
        child: BuildCardsBasedOnDimensions(
          posts: posts,
        ),
      ),
    );
  }
}

class BuildCardsBasedOnDimensions extends StatelessWidget {
  const BuildCardsBasedOnDimensions({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => kVerticalDivider,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post: post);
            },
          );
        } else {
          return SizedBox(
            width: 1200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.5,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCard(post: post);
              },
            ),
          );
        }
      },
    );
  }
}
