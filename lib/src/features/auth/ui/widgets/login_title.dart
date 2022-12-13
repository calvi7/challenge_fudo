import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key, required this.title, this.fontSize});

  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize ?? 40,
      ),
      textAlign: TextAlign.center,
    );
  }
}
