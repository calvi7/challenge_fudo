import 'package:challenge_fudo/src/features/auth/ui/pages/login_page.dart';
import 'package:challenge_fudo/src/features/posts/ui/pages/posts_page.dart';
import 'package:challenge_fudo/src/shared_widgets/scaffold_with_bottom_navbar.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _baseNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _baseNavigatorKey,
  // TODO: change initialLocation back to '/'
  initialLocation: '/posts',
  routes: [
    GoRoute(
      path: '/',
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
          path: '/users',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: kEmptyWidget,
          ),
        ),
        GoRoute(
          path: '/posts',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PostsPage(),
          ),
        ),
      ],
    ),
  ],
);
