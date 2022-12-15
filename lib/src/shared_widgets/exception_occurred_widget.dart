import 'package:challenge_fudo/src/utils/extensions.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class ExceptionOccurredWidget extends StatelessWidget {
  const ExceptionOccurredWidget({
    super.key,
    required this.onRetry,
    this.message,
  });

  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Container(
        width: context.media.size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.theme.colorScheme.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message ?? "An Exception Occurred!",
              ),
              kVerticalDivider,
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: onRetry,
                child: const Text("Retry?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
