import 'package:challenge_fudo/src/features/posts/bloc/posts_bloc.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/features/posts/ui/pages/posts_loaded_view.dart';
import 'package:challenge_fudo/src/shared_widgets/exception_occurred_widget.dart';
import 'package:challenge_fudo/src/shared_widgets/loading_widget.dart';
import 'package:challenge_fudo/src/utils/show_toast.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(
        GetIt.I<PostsRepository>(),
      )..add(PostsFetched()),
      child: const PostsPageBody(),
    );
  }
}

class PostsPageBody extends StatelessWidget {
  const PostsPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      listener: _listener,
      builder: (context, state) {
        if (state is PostsLoaded) {
          return PostsLoadedView(posts: state.posts);
        } else if (state is PostsLoading) {
          return const Center(child: LoadingWidget());
        } else if (state is PostsError) {
          return Center(
            child: ExceptionOccurredWidget(
                onRetry: () => context.read<PostsBloc>().add(PostsFetched())),
          );
        } else {
          return kEmptyWidget;
        }
      },
    );
  }

  void _listener(context, state) {
    if (state is PostsError) {
      showErrorToast(context, state.message);
    } else if (state is PostsNotification) {
      showSuccessToast(context, state.message);
    }
  }
}
