import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:challenge_fudo/src/features/auth/utils/auth_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNavbar extends StatefulWidget {
  const ScaffoldWithBottomNavbar({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  State<ScaffoldWithBottomNavbar> createState() =>
      _ScaffoldWithBottomNavbarState();
}

class _ScaffoldWithBottomNavbarState extends State<ScaffoldWithBottomNavbar> {
  final List<String> _bottomRoutes = [
    '/users',
    '/posts',
  ];

  int _locationToTabIndex(String location) {
    final index = _bottomRoutes.indexWhere((val) => location.startsWith(val));
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  void _onItemTapped(BuildContext context, int tabIndex) {
    final value = tabIndex != _currentIndex;
    if (value) {
      context.go(_bottomRoutes[tabIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: authListener,
      child: Scaffold(
        body: widget.body,
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontSize: 14),
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          elevation: 30,
          mouseCursor: MouseCursor.defer,
          enableFeedback: true,
          currentIndex: _currentIndex,
          onTap: (value) => _onItemTapped(context, value),
          items: const [
            BottomNavigationBarItem(
              label: "Users",
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: "Posts",
              icon: Icon(Icons.post_add),
            ),
          ],
        ),
      ),
    );
  }
}
