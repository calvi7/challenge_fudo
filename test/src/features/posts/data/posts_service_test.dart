import 'package:challenge_fudo/src/features/posts/data/posts_service.dart';
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
  });
}
