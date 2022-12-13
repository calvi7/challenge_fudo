import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:challenge_fudo/src/features/auth/data/auth_repository.dart';
import 'package:challenge_fudo/src/utils/durations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "AuthBloc",
    () {
      blocTest(
        'emits [] when nothing is added.',
        build: () => AuthBloc(AuthRepository()),
        expect: () => const <AuthState>[],
      );

      blocTest(
        'emits [AuthLoading, AuthError] when an incorrent username is passed',
        build: () => AuthBloc(AuthRepository()),
        act: (bloc) => bloc.add(
          AuthLoginAttempted(username: "incorrect", password: "password"),
        ),
        wait: Durations.ms500,
        expect: () => [
          const AuthLoading(),
          isA<AuthError>(),
          const AuthInitial(false),
        ],
      );

      blocTest(
        'emits [AuthLoading, AuthError, ] when an incorrent password is passed',
        build: () => AuthBloc(AuthRepository()),
        act: (bloc) => bloc.add(
          AuthLoginAttempted(username: "challenge@fudo", password: "incorrect"),
        ),
        wait: Durations.ms500,
        expect: () => [
          const AuthLoading(),
          isA<AuthError>(),
          const AuthInitial(false),
        ],
      );

      blocTest(
        'emits [AuthLoading, UserAuthenticated] when correct user is passed',
        build: () => AuthBloc(AuthRepository()),
        act: (bloc) => bloc.add(
          AuthLoginAttempted(
            username: "challenge@fudo",
            password: "password",
          ),
        ),
        wait: Durations.ms500,
        expect: () => const <AuthState>[
          AuthLoading(),
          UserAuthenticated(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthInitial] when user logs out',
        build: () => AuthBloc(AuthRepository()),
        act: (bloc) => bloc.add(
          AuthUserLoggedOut(),
        ),
        seed: () => const UserAuthenticated(),
        expect: () => const <AuthState>[
          UserUnauthenticated(),
          AuthInitial(false),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthError, AuthInitial] when error occurs',
        build: () => AuthBloc(
          AuthRepository(),
        ),
        act: (bloc) => bloc.add(
          AuthErrorOccurred("Error 404"),
        ),
        seed: () => const UserUnauthenticated(),
        expect: () => const <AuthState>[
          AuthError("Error 404"),
          AuthInitial(false),
        ],
      );
    },
  );
}
