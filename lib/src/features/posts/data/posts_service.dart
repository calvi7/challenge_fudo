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
}
