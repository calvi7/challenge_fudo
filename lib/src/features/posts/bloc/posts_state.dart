// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object?> get props => [message];
}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsNotification extends PostsState {
  final String message;

  const PostsNotification(this.message);

  @override
  List<Object?> get props => [message];
}
