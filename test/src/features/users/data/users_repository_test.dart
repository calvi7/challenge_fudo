import 'package:challenge_fudo/src/features/users/data/users_repository.dart';
import 'package:challenge_fudo/src/features/users/data/users_service.dart';
import 'package:challenge_fudo/src/features/users/domain/company.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const kFirstCompany = Company(
  name: "Deckow-Crist",
  catchPhrase: "Proactive didactic contingency",
  bs: "synergize scalable supply-chains",
);

const kSecondCompany = Company(
  name: "Romaguera-Jacobson",
  catchPhrase: "Face to face bifurcated interface",
  bs: "e-enable strategic applications",
);

const kValidResponse =
    """[{
    "id": 2,
    "name": "Ervin Howell",
    "username": "Antonette",
    "email": "Shanna@melissa.tv",
    "address": {
      "street": "Victor Plains",
      "suite": "Suite 879",
      "city": "Wisokyburgh",
      "zipcode": "90566-7771",
      "geo": {
        "lat": "-43.9509",
        "lng": "-34.4618"
      }
    },
    "phone": "010-692-6593 x09125",
    "website": "anastasia.net",
    "company": {
      "name": "Deckow-Crist",
      "catchPhrase": "Proactive didactic contingency",
      "bs": "synergize scalable supply-chains"
    }
  },
  {
    "id": 3,
    "name": "Clementine Bauch",
    "username": "Samantha",
    "email": "Nathan@yesenia.net",
    "address": {
      "street": "Douglas Extension",
      "suite": "Suite 847",
      "city": "McKenziehaven",
      "zipcode": "59590-4157",
      "geo": {
        "lat": "-68.6102",
        "lng": "-47.0653"
      }
    },
    "phone": "1-463-123-4447",
    "website": "ramiro.info",
    "company": {
      "name": "Romaguera-Jacobson",
      "catchPhrase": "Face to face bifurcated interface",
      "bs": "e-enable strategic applications"
    }
  }]""";

class MockUsersService extends Mock implements UsersService {
  MockUsersService() {
    when(() => getUsers()).thenAnswer(
      (_) async => kValidResponse,
    );
  }
}

void main() {
  late UsersRepository sut;
  late UsersService service;

  setUp(() {
    service = MockUsersService();
    sut = UsersRepository(service);
  });

  group("UsersRepository tests ...", () {
    test('get users', () async {
      final users = await sut.getUsers();

      expect(users.length, equals(2));

      final first = users[0];
      final second = users[1];

      expect(first.name, equals("Ervin Howell"));
      expect(first.email, equals("Shanna@melissa.tv"));
      expect(first.company, equals(kFirstCompany));

      expect(second.name, equals("Clementine Bauch"));
      expect(second.email, equals("Nathan@yesenia.net"));
      expect(second.company, equals(kSecondCompany));
    });
  });
}
