import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_fudo/src/features/posts/bloc/posts_bloc.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/features/posts/domain/exceptions.dart';
import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

class MockPostsRepository extends Mock implements PostsRepository {
  MockPostsRepository();
}

const kPost1 = Post(
  userId: 1,
  id: 1,
  title: "Test 1",
  body: "Test 1 body",
);

const kPost2 = Post(
  userId: 2,
  id: 2,
  title: "Test 2",
  body: "Test 2 body",
);

void main() {
  late MockStorage storage;
  late PostsRepository repository;

  void setupStorageReturnsNull() {
    when(() => storage.write(any(), any())).thenAnswer((_) async {});
    when(() => storage.read(any())).thenAnswer((_) async {});
  }

  void setupReturnsPosts() {
    setupStorageReturnsNull();
    when(() => repository.getPosts()).thenAnswer(
      (_) async => [
        kPost1,
        kPost2,
      ],
    );
  }

  void setupThrowsException() {
    setupStorageReturnsNull();
    when(() => repository.getPosts()).thenAnswer(
      (_) async => throw Exception("Error 404"),
    );
  }

  void setupCreatesPost() {
    setupStorageReturnsNull();
    when(() => repository.createPost(kPost1)).thenAnswer((_) async {});
  }

  setUp(() {
    storage = MockStorage();
    HydratedBloc.storage = storage;
    repository = MockPostsRepository();
  });

  group("PostsBloc...", () {
    blocTest(
      "emmits [] when nothing is added",
      build: () => PostsBloc(repository),
      setUp: () => setupReturnsPosts(),
      expect: () => [],
    );

    blocTest(
      'emits [PostsLoading, PostsLoaded] when PostsFetched is added',
      build: () => PostsBloc(repository),
      setUp: () => setupReturnsPosts(),
      act: (bloc) => bloc.add(PostsFetched()),
      expect: () => [
        const PostsLoading(),
        const PostsLoaded([kPost1, kPost2]),
      ],
    );

    blocTest<PostsBloc, PostsState>(
      'emits [] when state is PostsLoaded and fecthing',
      build: () => PostsBloc(repository),
      setUp: () => setupReturnsPosts(),
      seed: () => const PostsLoaded([kPost1, kPost2]),
      act: (bloc) => bloc.add(PostsFetched()),
      expect: () => [],
    );

    blocTest(
      'emits [PostsLoading, PostsError] when Exception occurs',
      build: () => PostsBloc(repository),
      setUp: () => setupThrowsException(),
      act: (bloc) => bloc.add(PostsFetched()),
      expect: () => [
        const PostsLoading(),
        const PostsError('Exception: Error 404'),
      ],
    );

    blocTest<PostsBloc, PostsState>(
      'emits [PostsLoading, PostsNotification, PostsLoaded] when NewPostCreated is added.',
      build: () => PostsBloc(repository),
      act: (bloc) => bloc.add(NewPostCreated(kPost1)),
      seed: () => const PostsLoaded([]),
      setUp: () => setupCreatesPost(),
      expect: () => [
        const PostsLoading(),
        isA<PostsNotification>(),
        const PostsLoaded([kPost1]),
      ],
    );

    blocTest<PostsBloc, PostsState>(
      'emits [PostsLoading, PostsNotification, PostsLoaded] when Exception occurs while creating',
      build: () => PostsBloc(repository),
      setUp: () {
        setupStorageReturnsNull();
        when(() => repository.createPost(kPost1)).thenAnswer(
          (invocation) => throw PostCreationException(),
        );
      },
      seed: () => const PostsLoaded([kPost2]),
      act: (bloc) => bloc.add(NewPostCreated(kPost1)),
      expect: () => [
        const PostsLoading(),
        isA<PostsError>(),
        const PostsLoaded([kPost2]),
      ],
    );
  });
}
