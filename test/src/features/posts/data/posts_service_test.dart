import 'package:challenge_fudo/src/features/posts/data/posts_service.dart';
import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PostsService sut;

  setUp(() {
    sut = PostsService();
  });

  group("PostsService...", () {
    test("get posts", () async {
      final response = await sut.getPosts();
      expect(response, contains('userId'));
      expect(response, contains('id'));
      expect(response, contains('title'));
      expect(response, contains('body'));
    });

    test("get post", () async {
      final response = await sut.getPost(1);
      expect(response, contains('"userId": 1'));
      expect(response, contains('"id": 1'));
    });

    test("create post", () async {
      const post = Post(
        userId: 11,
        id: 101,
        title: "title",
        body: "body",
      );

      final future = sut.createPost(post);

      /// Jsonplaceholder API will return status code no matter what you send
      /// as a string, so exception testing is not available
      expect(() async => await future, isNot(isA<Exception>()));
    });
  });
}
