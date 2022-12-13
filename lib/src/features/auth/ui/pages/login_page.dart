import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:challenge_fudo/src/features/auth/utils/auth_listener.dart';
import 'package:challenge_fudo/src/shared_widgets/loading_widget.dart';
import 'package:challenge_fudo/src/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        authListener(context, state);
        if (state is AuthError) {
          showErrorToast(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: state is AuthLoading
                ? const LoadingWidget()
                : const LoginView(),
          ),
        );
      },
    );
  }
}
