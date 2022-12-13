import 'package:challenge_fudo/src/features/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ThemeBuilder = Widget Function(
  BuildContext context,
  ThemeMode themeMode,
);

class ThemeModeBuilder extends StatelessWidget {
  const ThemeModeBuilder({super.key, required this.builder});

  final ThemeBuilder builder;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeBloc>().state;
    return builder(context, theme);
  }
}
