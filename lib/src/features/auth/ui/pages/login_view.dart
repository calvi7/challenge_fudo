import 'package:challenge_fudo/src/features/auth/bloc/auth_bloc.dart';
import 'package:challenge_fudo/src/features/auth/ui/widgets/login_title.dart';
import 'package:challenge_fudo/src/shared_widgets/input_box.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController userController;
  late TextEditingController passController;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const LoginTitle(title: "FUDO"),
        Column(
          children: [
            InputBox(
              controller: userController,
              inputType: TextInputType.emailAddress,
            ),
            kVerticalDivider,
            InputBox(
              controller: passController,
              obscure: true,
            ),
            kVerticalDivider,
          ],
        ),
        ElevatedButton(
          onPressed: () => context.read<AuthBloc>().add(
                AuthLoginAttempted(
                  username: userController.text,
                  password: passController.text,
                ),
              ),
          child: const Text("LOGIN"),
        )
      ],
    );
  }
}
