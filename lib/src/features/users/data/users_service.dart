import 'package:http/http.dart' as http;

class UsersService {
  final String _url = 'jsonplaceholder.typicode.com';

  Future<String> getUsers() async {
    final uri = Uri.https(_url, 'users');
    final response = await http.get(uri);

    return response.body;
  }
}
