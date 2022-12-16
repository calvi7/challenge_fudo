import 'package:challenge_fudo/src/features/posts/bloc/posts_bloc.dart';
import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:challenge_fudo/src/features/posts/ui/widgets/post_card.dart';
import 'package:challenge_fudo/src/shared_widgets/app_end_drawer.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostsLoadedView extends StatelessWidget {
  const PostsLoadedView({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      endDrawer: const AppEndDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.go('/posts/new'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<PostsBloc>().add(
              PostsRefreshed(),
            ),
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: SizedBox.expand(
          child: BuildCardsBasedOnDimensions(
            posts: posts,
          ),
        ),
      ),
    );
  }
}

class PostsViewFloatingActionButtons extends StatelessWidget {
  const PostsViewFloatingActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [],
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
          return Center(
            child: SizedBox(
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
            ),
          );
        }
      },
    );
  }
}
