import 'package:challenge_fudo/src/app/app.dart';
import 'package:challenge_fudo/src/features/auth/data/auth_repository.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_service.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final path = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: path);

  final authRepository = AuthRepository();

  final postsService = PostsService();
  final postsRepository = PostsRepository(postsService);

  runApp(
    App(
      authRepository: authRepository,
      postsRepository: postsRepository,
    ),
  );
}
