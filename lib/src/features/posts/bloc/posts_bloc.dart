import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/features/posts/domain/exceptions.dart';
import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends HydratedBloc<PostsEvent, PostsState> {
  PostsBloc(this._repository) : super(const PostsInitial()) {
    on<PostsFetched>(_onPostsFetched);
    on<NewPostCreated>(_onNewPostCreated);
    on<PostsRefreshed>(_onPostsRefreshed);
  }

  final PostsRepository _repository;

  Future<void> _onPostsFetched(
    PostsFetched event,
    Emitter<PostsState> emit,
  ) async {
    try {
      if (state is PostsLoaded) return;
      emit(const PostsLoading());
      final posts = await _repository.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> _onNewPostCreated(
    NewPostCreated event,
    Emitter<PostsState> emit,
  ) async {
    final posts = _getPostsFromState(state);
    final post = event.post;
    try {
      emit(const PostsLoading());
      await _repository.createPost(event.post);
      emit(const PostsNotification('Post created successfully!'));

      final newPosts = [...posts, post];
      emit(PostsLoaded(newPosts));
    } on PostCreationException {
      emit(const PostsError("Couldn't create the post. Try again later."));
      emit(PostsLoaded(posts));
    } on Exception catch (e) {
      emit(PostsError(e.toString()));
      emit(PostsLoaded(posts));
    }
  }

  List<Post> _getPostsFromState(PostsState state) {
    return state is PostsLoaded ? state.posts : const <Post>[];
  }

  Future<void> _onPostsRefreshed(
    PostsRefreshed event,
    Emitter<PostsState> emit,
  ) async {
    try {
      emit(const PostsLoading());
      final posts = await _repository.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  @override
  PostsState? fromJson(Map<String, dynamic> json) {
    final postList = json['posts'];

    if (postList.isNotEmpty) {
      final List<Post> posts = [];

      for (final value in postList) {
        posts.add(Post.fromMap(value));
      }

      return PostsLoaded(posts);
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(PostsState state) {
    final posts = state is PostsLoaded ? state.posts : const <Post>[];

    return {
      'posts': posts.map((e) => e.toMap()).toList(),
    };
  }
}
