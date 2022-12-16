import 'package:challenge_fudo/src/features/posts/domain/exceptions.dart';
import 'package:challenge_fudo/src/features/posts/domain/post.dart';
import 'package:http/http.dart' as http;

class PostsService {
  final _url = "jsonplaceholder.typicode.com";

  Future<String> getPosts() async {
    final uri = Uri.https(_url, "posts");

    final res = await http.get(uri);

    return res.body;
  }

  Future<String> getPost(int id) async {
    final uri = Uri.https(_url, "posts/$id");

    final res = await http.get(uri);

    return res.body;
  }

  Future<void> createPost(Post post) async {
    final uri = Uri.https(_url, "posts");

    final res = await http.post(uri, body: post.toJson());

    if (res.statusCode != 201) {
      throw PostCreationException();
    }
  }
}
