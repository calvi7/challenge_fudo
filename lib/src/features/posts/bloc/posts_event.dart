part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {}

class PostsFetched extends PostsEvent {
  @override
  List<Object?> get props => [];
}
