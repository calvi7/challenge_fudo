import 'package:flutter/material.dart';

Future<void> showErrorToast(BuildContext context, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 20,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}

Future<void> showSuccessToast(BuildContext context, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 20,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: Colors.green,
    ),
  );
}
