import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required this.controller,
    this.obscure = false,
    this.inputType,
  });

  final TextEditingController controller;
  final bool obscure;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          fillColor: Colors.grey,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        obscureText: obscure,
        autocorrect: obscure,
        keyboardType: inputType,
      ),
    );
  }
}
