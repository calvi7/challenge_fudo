import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  const InputBox({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.inputType,
    this.hint,
  });

  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? inputType;
  final String? hint;

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.isPassword;
    super.initState();
  }

  void toggleObscure() => setState(() {
        _obscure = !_obscure;
      });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? PasswordIcon(
                    obscure: _obscure,
                    onPressed: toggleObscure,
                  )
                : null,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            hintText: widget.hint,
          ),
          obscureText: _obscure,
          style: const TextStyle(color: Colors.black),
          autocorrect: !widget.isPassword,
          keyboardType: widget.inputType,
        ),
      ),
    );
  }
}

class PasswordIcon extends StatelessWidget {
  const PasswordIcon({
    super.key,
    required this.obscure,
    required this.onPressed,
  });

  final bool obscure;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: obscure
          ? const Icon(
              Icons.visibility_off,
              color: Colors.black,
            )
          : const Icon(
              Icons.visibility,
              color: Colors.black,
            ),
    );
  }
}
