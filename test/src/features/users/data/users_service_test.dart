import 'package:challenge_fudo/src/features/users/data/users_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UsersService sut;

  setUp(() {
    sut = UsersService();
  });

  group('UserService tests...', () {
    test('get users', () async {
      final response = await sut.getUsers();

      expect(response, contains('"id": 1,'));
      expect(response, contains('"name": "Leanne Graham",'));
      expect(response, contains('"email": "Sincere@april.biz",'));
      expect(response, contains('"phone": "1-770-736-8031 x56442",'));

      expect(response, contains('"id": 3,'));
      expect(response, contains('"name": "Clementine Bauch",'));
      expect(response, contains('"email": "Nathan@yesenia.net",'));
      expect(response, contains('"phone": "1-463-123-4447",'));
    });
  });
}
