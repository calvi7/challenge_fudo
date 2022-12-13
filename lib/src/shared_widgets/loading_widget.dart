import 'package:challenge_fudo/src/shared_widgets/wave_dots_animation.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const WaveDots(size: 50, color: Colors.black87);
  }
}
