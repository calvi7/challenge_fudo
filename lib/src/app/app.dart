import 'package:challenge_fudo/src/app/routing/router.dart';
import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:challenge_fudo/src/features/auth/data/auth_repository.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
    required this.postsRepository,
  });

  final AuthRepository authRepository;
  final PostsRepository postsRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository),
      child: MaterialApp.router(
        routerConfig: goRouter,
      ),
    );
  }
}
