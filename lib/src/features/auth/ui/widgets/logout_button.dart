import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<AuthBloc>().add(AuthUserLoggedOut()),
      icon: const Icon(Icons.logout),
    );
  }
}
