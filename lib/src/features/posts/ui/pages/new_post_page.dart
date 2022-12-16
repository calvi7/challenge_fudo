import 'package:challenge_fudo/src/features/posts/bloc/posts_bloc.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:challenge_fudo/src/shared_widgets/app_end_drawer.dart';
import 'package:challenge_fudo/src/shared_widgets/input_box.dart';
import 'package:challenge_fudo/src/shared_widgets/loading_widget.dart';
import 'package:challenge_fudo/src/utils/show_toast.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _bodyController = TextEditingController()..addListener(_listener);
    _titleController = TextEditingController()..addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    bool canSend =
        _bodyController.text.isNotEmpty && _titleController.text.isNotEmpty;
    return BlocProvider(
      create: (context) => PostsBloc(GetIt.I<PostsRepository>()),
      child: BlocConsumer<PostsBloc, PostsState>(
        listener: _blocListener,
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () =>
                  canSend ? _createPost(context) : _showTextErrorToast(context),
              label: const Text("Create post"),
              icon: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: AppBar(
              title: const Text("New post"),
            ),
            endDrawer: const AppEndDrawer(),
            body: Center(
              child: state is PostsLoading
                  ? const LoadingWidget()
                  : NewPostBody(
                      titleController: _titleController,
                      bodyController: _bodyController,
                    ),
            ),
          );
        },
      ),
    );
  }

  void _listener() => setState(() {});

  void _blocListener(BuildContext context, PostsState state) {
    if (state is PostsLoaded) {
      context.pop();
    } else if (state is PostsNotification) {
      showSuccessToast(context, state.message);
    } else if (state is PostsError) {
      showErrorToast(context, state.message);
    }
  }

  void _showTextErrorToast(BuildContext context) {
    showErrorToast(context, "Title and body must not be empty");
  }

  void _createPost(BuildContext context) {
    final bloc = context.read<PostsBloc>();
    final id = bloc.state is PostsLoaded
        ? (bloc.state as PostsLoaded).posts.length + 1
        : 1;

    final post = Post(
      userId: 11,
      id: id,
      title: _titleController.text,
      body: _bodyController.text,
    );

    bloc.add(NewPostCreated(post));
    // context.go('/posts');
  }
}

class NewPostBody extends StatelessWidget {
  const NewPostBody({
    super.key,
    required this.titleController,
    required this.bodyController,
  });

  final TextEditingController titleController;
  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputBox(
          controller: titleController,
          hint: "Title of your post",
        ),
        kVerticalDivider,
        InputBox(
          controller: bodyController,
          maxLines: 10,
          minLines: 10,
          hint: "Body of your post",
        ),
      ],
    );
  }
}
