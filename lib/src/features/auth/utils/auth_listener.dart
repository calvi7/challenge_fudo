import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void authListener(BuildContext context, AuthState state) {
  if (state is UserAuthenticated) {
    context.go('/users');
  } else if (state is UserUnauthenticated) {
    context.go('/');
  }
}
