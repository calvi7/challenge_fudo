import 'package:challenge_fudo/src/features/auth/data/auth_repository.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_repository.dart';
import 'package:challenge_fudo/src/features/posts/data/posts_service.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final getIt = GetIt.instance;

    final authRepository = AuthRepository();
    final postsService = PostsService();
    final postsRepository = PostsRepository(postsService);

    getIt.registerLazySingleton<AuthRepository>(() => authRepository);
    getIt.registerLazySingleton<PostsRepository>(() => postsRepository);
  }
}
