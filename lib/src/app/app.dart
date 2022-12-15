import 'package:challenge_fudo/src/app/routing/router.dart';
import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:challenge_fudo/src/features/auth/data/auth_repository.dart';
import 'package:challenge_fudo/src/features/theme/bloc/theme_bloc.dart';
import 'package:challenge_fudo/src/features/theme/ui/widgets/theme_mode_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: ThemeModeBuilder(
        builder: (context, themeMode) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          routerConfig: goRouter,
        ),
      ),
    );
  }
}
