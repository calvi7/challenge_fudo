import 'package:challenge_fudo/src/features/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeSwitch extends StatelessWidget {
  const ThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.read<ThemeBloc>().add(ThemeModeToggled()),
          icon: state == ThemeMode.light
              ? const Icon(Icons.light_mode)
              : const Icon(Icons.dark_mode),
        );
      },
    );
  }
}
