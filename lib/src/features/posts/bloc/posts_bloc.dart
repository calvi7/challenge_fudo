import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends HydratedBloc<PostsEvent, PostsState> {
  PostsBloc(this._repository) : super(PostsInitial()) {
    on<PostsFetched>(_onPostsFetched);
  }

  final PostsRepository _repository;

  Future<void> _onPostsFetched(
    PostsFetched event,
    Emitter<PostsState> emit,
  ) async {
    try {
      if (state is PostsLoaded) return;

      emit(PostsLoading());
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
