import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_fudo/src/features/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {
  MockStorage() {
    when(() => read(any())).thenAnswer((_) async {});
    when(() => write(any(), any())).thenAnswer((_) async {});
  }
}

void main() {
  group(
    "ThemeBloc...",
    () {
      setUp(() {
        HydratedBloc.storage = MockStorage();
      });

      blocTest<ThemeBloc, ThemeMode>(
        'emits [ThemeMode.dark] when ThemeModeToggled is added.',
        build: () => ThemeBloc(),
        act: (bloc) => bloc.add(ThemeModeToggled()),
        expect: () => const [
          ThemeMode.dark,
        ],
      );

      blocTest<ThemeBloc, ThemeMode>(
        'emits [ThemeMode.light] when ThemeModeToggled is added AND seed is ThemeMode.dark',
        build: () => ThemeBloc(),
        seed: () => ThemeMode.dark,
        act: (bloc) => bloc.add(ThemeModeToggled()),
        expect: () => const [
          ThemeMode.light,
        ],
      );

      blocTest<ThemeBloc, ThemeMode>(
        'emits [ThemeMode.dark, ThemeMode.light] when ThemeModeToggled is added twice',
        build: () => ThemeBloc(),
        act: (bloc) => bloc
          ..add(ThemeModeToggled())
          ..add(ThemeModeToggled()),
        expect: () => const [
          ThemeMode.dark,
          ThemeMode.light,
        ],
      );
    },
  );
}
