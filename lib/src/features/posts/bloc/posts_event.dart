part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {}

class PostsFetched extends PostsEvent {
  @override
  List<Object?> get props => [];
}

class NewPostCreated extends PostsEvent {
  final Post post;

  NewPostCreated(this.post);

  @override
  List<Object?> get props => [post];
}

class PostsRefreshed extends PostsEvent {
  @override
  List<Object?> get props => [];
}

class PostsCleared extends PostsEvent {
  @override
  List<Object?> get props => [];
}
