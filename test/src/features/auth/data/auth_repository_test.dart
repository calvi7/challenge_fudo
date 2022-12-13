import 'package:challenge_fudo/src/features/auth/data/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthRepository sut;

  group("AuthRepository ...", () {
    setUp(() {
      sut = AuthRepository();
    });

    test('invalid username', () async {
      const username = "invalid";
      final password = sut.kValidPassword;

      final result = await sut.login(username: username, password: password);
      expect(result, equals(false));
    });

    test('invalid password', () async {
      final username = sut.kValidUsername;
      const password = "invalid";

      final result = await sut.login(username: username, password: password);
      expect(result, equals(false));
    });

    test('valid data', () async {
      final username = sut.kValidUsername;
      final password = sut.kValidPassword;

      final result = await sut.login(username: username, password: password);
      expect(result, equals(true));
    });
  });
}
