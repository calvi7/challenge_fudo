import 'package:challenge_fudo/src/features/users/data/users_service.dart';
import 'package:challenge_fudo/src/features/users/domain/user.dart';

class UsersRepository {
  final UsersService _service;

  UsersRepository(this._service);

  Future<List<User>> getUsers() async {
    final usersResponse = await _service.getUsers();
    final users = usersFromJson(usersResponse);

    return users;
  }
}
