import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_fudo/src/features/users/bloc/users_bloc.dart';
import 'package:challenge_fudo/src/features/users/data/users_repository.dart';
import 'package:challenge_fudo/src/features/users/domain/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../theme/bloc/theme_bloc_test.dart';

const _res =
    """{
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  }""";

final kValidUser = User.fromJson(jsonDecode(_res));

class MockUsersRepository extends Mock implements UsersRepository {
  MockUsersRepository() {
    when(() => getUsers()).thenAnswer(
      (_) async => [kValidUser, kValidUser, kValidUser],
    );
  }
}

void main() {
  late UsersRepository repository;

  setUp(() {
    HydratedBloc.storage = MockStorage();
    repository = MockUsersRepository();
  });

  blocTest(
    'emits [] when nothing is added',
    build: () => UsersBloc(repository),
    expect: () => [],
  );

  blocTest(
    'emits [UsersLoading, UsersLoaded] when UsersFetched is added',
    build: () => UsersBloc(repository),
    act: (bloc) => bloc.add(UsersFetched()),
    expect: () => [
      UsersLoading(),
      UsersLoaded([kValidUser, kValidUser, kValidUser]),
    ],
  );

  blocTest(
    'emits [UsersLoading, UsersError] when Exception occurs',
    build: () => UsersBloc(repository),
    setUp: () => when(() => repository.getUsers()).thenAnswer(
      (_) async => throw Exception('Error 404'),
    ),
    act: (bloc) => bloc.add(UsersFetched()),
    expect: () => [
      UsersLoading(),
      isA<UsersError>(),
    ],
  );
}
