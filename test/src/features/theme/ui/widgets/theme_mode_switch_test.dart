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
        themeMode: bloc.state,
        darkTheme: ThemeData.dark(),
        home: Material(
          child: BlocProvider.value(
            value: bloc,
            child: const ThemeModeSwitch(),
          ),
        ),
      );

  group("ThemeModeSwitch...", () {
    testWidgets(
      "can toggle icon",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildWidget());
        final findLightIcon = find.byIcon(Icons.light_mode);
        final findDarkIcon = find.byIcon(Icons.dark_mode);

        expect(findLightIcon, findsOneWidget);
        expect(findDarkIcon, findsNothing);

        expect(bloc.state, equals(ThemeMode.light));

        await tester.tap(find.byType(ThemeModeSwitch));
        await tester.pumpAndSettle();

        // TODO: check that the icon changes

        /// bloc changes state correctly
        expect(bloc.state, equals(ThemeMode.dark));
      },
    );
  });
}
