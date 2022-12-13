import 'package:challenge_fudo/src/features/posts/bloc/posts_bloc.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/features/posts/ui/pages/posts_loaded_view.dart';
import 'package:challenge_fudo/src/shared_widgets/loading_widget.dart';
import 'package:challenge_fudo/src/utils/show_toast.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(
        context.read<PostsRepository>(),
      )..add(PostsFetched()),
      child: BlocConsumer<PostsBloc, PostsState>(
        listener: _listener,
        builder: (context, state) => state is PostsLoaded
            ? PostsLoadedView(posts: state.posts)
            : state is PostsLoading
                ? const Center(
                    child: LoadingWidget(),
                  )
                : kEmptyWidget,
      ),
    );
  }

  void _listener(context, state) {
    if (state is PostsError) {
      showErrorToast(context, state.message);
    }
  }
}
