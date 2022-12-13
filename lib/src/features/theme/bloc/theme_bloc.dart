import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<ThemeModeToggled>(_onThemeModeToggled);
  }

  void _onThemeModeToggled(ThemeModeToggled event, Emitter<ThemeMode> emit) {
    if (state.name == 'dark') {
      emit(ThemeMode.light);
    } else if (state.name == 'light') {
      emit(ThemeMode.dark);
    }
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final name = json['theme'];
    if (name == 'dark') {
      return ThemeMode.dark;
    } else if (name == 'light') {
      return ThemeMode.light;
    } else if (name == 'system') {
      return ThemeMode.system;
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme': state.name};
  }
}
