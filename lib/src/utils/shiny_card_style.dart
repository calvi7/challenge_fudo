import 'package:challenge_fudo/src/utils/colors.dart';
import 'package:flutter/material.dart';

class ShinyCardStyle {
  final Color shadowColor;
  final LinearGradient gradient;

  ShinyCardStyle({
    required this.shadowColor,
    required this.gradient,
  });

  static final blue = ShinyCardStyle(
    shadowColor: CustomColors.blue2,
    gradient: LinearGradients.blue,
  );

  static final red = ShinyCardStyle(
    shadowColor: CustomColors.red2,
    gradient: LinearGradients.red,
  );

  static final orange = ShinyCardStyle(
    shadowColor: CustomColors.orange2,
    gradient: LinearGradients.orange,
  );

  static final purple = ShinyCardStyle(
    shadowColor: CustomColors.purple2,
    gradient: LinearGradients.purple,
  );

  static final all = [purple, orange, red, blue];
}
