import 'dart:async';

import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:challenge_fudo/src/features/auth/ui/pages/login_page.dart';
import 'package:challenge_fudo/src/features/posts/ui/pages/new_post_page.dart';
import 'package:challenge_fudo/src/features/posts/ui/pages/posts_page.dart';
import 'package:challenge_fudo/src/features/users/ui/pages/users_page.dart';
import 'package:challenge_fudo/src/shared_widgets/scaffold_with_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _baseNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _baseNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        final isAuthenticated = context.read<AuthBloc>().state.isAuthenticated;

        if (isAuthenticated) {
          return '/posts';
        }
        return '/';
      },
      pageBuilder: (context, state) => const MaterialPage(
        child: LoginPage(),
      ),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ScaffoldWithBottomNavbar(
        body: child,
      ),
      routes: [
        GoRoute(
          redirect: rerouteIfUnauthorized,
          path: '/users',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: UsersPage(),
          ),
        ),
        GoRoute(
          redirect: rerouteIfUnauthorized,
          path: '/posts',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PostsPage(),
          ),
          routes: [
            GoRoute(
              path: 'new',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: NewPostPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

FutureOr<String?> rerouteIfUnauthorized(
  BuildContext context,
  GoRouterState state,
) async {
  final isAuthenticated = context.read<AuthBloc>().state.isAuthenticated;

  if (!isAuthenticated) {
    return '/';
  }

  return null;
}
