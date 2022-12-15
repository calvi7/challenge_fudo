import 'package:challenge_fudo/src/app/app.dart';
import 'package:challenge_fudo/src/data/dependency_injection.dart';
import 'package:challenge_fudo/src/features/auth/data/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.initialize();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(
    App(
      authRepository: GetIt.I<AuthRepository>(),
    ),
  );
}
