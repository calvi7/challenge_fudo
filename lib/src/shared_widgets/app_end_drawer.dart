import 'package:challenge_fudo/src/features/auth/ui/widgets/logout_button.dart';
import 'package:challenge_fudo/src/features/theme/ui/widgets/theme_mode_switch.dart';
import 'package:flutter/material.dart';

class AppEndDrawer extends StatelessWidget {
  const AppEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Toggle Theme"),
              ThemeModeSwitch(),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Log out"),
              LogoutButton(),
            ],
          ),
        ],
      ),
    );
  }
}
