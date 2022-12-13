import 'package:challenge_fudo/src/features/posts/data/posts_service.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/utils/durations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const kValidResponse =
    """
[{
  "userId": 1,
  "id": 1,
  "title": "Test 1",
  "body": "Test 1 body"
},{
  "userId": 2,
  "id": 2,
  "title": "Test 2",
  "body": "Test 2 body"
}]
""";

const kSingleResponse =
    """
{
  "userId": 1,
  "id": 1,
  "title": "Test 1",
  "body": "Test 1 body"
}
""";

class MockPostsService extends Mock implements PostsService {
  MockPostsService() {
    setupGetPosts();
    setupGetPost();
  }

  void setupGetPosts() {
    when(() => getPosts()).thenAnswer((_) async {
      await Future.delayed(Durations.ms1000);
      return kValidResponse;
    });
  }

  void setupGetPost() {
    when(() => getPost(any())).thenAnswer((_) async {
      await Future.delayed(Durations.ms1000);
      return kSingleResponse;
    });
  }
}

void main() {
  late PostsRepository sut;
  late PostsService mockService;

  setUp(() {
    mockService = MockPostsService();
    sut = PostsRepository(mockService);
  });

  group("PostsRepository ...", () {
    test("get posts", () async {
      final posts = await sut.getPosts();
      final first = posts.first;
      final second = posts[1];

      expect(first.id, equals(1));
      expect(first.userId, equals(1));
      expect(first.title, equals("Test 1"));
      expect(first.body, equals("Test 1 body"));

      expect(second.id, equals(2));
      expect(second.userId, equals(2));
      expect(second.title, equals("Test 2"));
      expect(second.body, equals("Test 2 body"));
    });

    test("get post", () async {
      final post = await sut.getPost(1);

      expect(post.id, equals(1));
      expect(post.userId, equals(1));
      expect(post.title, equals("Test 1"));
      expect(post.body, equals("Test 1 body"));
    });
  });
}
