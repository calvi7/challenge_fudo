import 'package:flutter/material.dart';

import 'package:challenge_fudo/src/features/theme/bloc/theme_bloc.dart';
import 'package:challenge_fudo/src/features/theme/ui/widgets/theme_mode_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../bloc/theme_bloc_test.dart';

void main() {
  late ThemeBloc bloc;

  setUp(() {
    HydratedBloc.storage = MockStorage();
    bloc = ThemeBloc();
  });

  Widget buildWidget() => MaterialApp(
        home: Material(
          child: BlocProvider<ThemeBloc>.value(
            value: bloc,
            child: const ThemeModeSwitch(),
          ),
        ),
      );

  Widget buildWidgetAndBloc() => MaterialApp(
        home: Material(
          child: BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
            child: const ThemeModeSwitch(),
          ),
        ),
      );

  Finder findLightIcon() => find.byIcon(Icons.light_mode);
  Finder findDarkIcon() => find.byIcon(Icons.dark_mode);

  group("ThemeModeSwitch...", () {
    testWidgets(
      'initial button is light',
      (tester) async {
        await tester.pumpWidget(buildWidget());
        expect(findLightIcon(), findsOneWidget);
        expect(findDarkIcon(), findsNothing);
        expect(bloc.state, equals(ThemeMode.light));
      },
    );

    testWidgets(
      'initial button is dark when ThemeBloc\'s theme is dark',
      (tester) async {
        bloc.add(ThemeModeToggled());
        await tester.pumpWidget(buildWidget());
        expect(findDarkIcon(), findsOneWidget);
        expect(findLightIcon(), findsNothing);
        expect(bloc.state, equals(ThemeMode.dark));
      },
    );

    testWidgets(
      "can toggle icon",
      (tester) async {
        /// We use a different bloc, since the tester has issues when the bloc
        /// is created previously.
        await tester.pumpWidget(buildWidgetAndBloc());

        expect(findLightIcon(), findsOneWidget);
        expect(findDarkIcon(), findsNothing);

        await tester.tap(findLightIcon());
        await tester.pumpAndSettle();

        expect(findLightIcon(), findsNothing);
        expect(findDarkIcon(), findsOneWidget);
      },
    );
  });
}
