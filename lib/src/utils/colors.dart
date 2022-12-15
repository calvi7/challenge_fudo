import 'package:flutter/material.dart';

abstract class CustomColors {
  static const lightPurple = Color.fromRGBO(233, 210, 255, 1);
  static const black = Color.fromRGBO(23, 23, 23, 1);
  static const deepGrey = Color.fromRGBO(50, 50, 50, 1);

  static const purple2 = Color.fromRGBO(194, 123, 243, 1);
  static const purple1 = Color.fromRGBO(157, 127, 244, 1);

  static const blue1 = Color.fromRGBO(130, 192, 242, 1);
  static const blue2 = Color.fromRGBO(125, 159, 243, 1);

  static const orange1 = Color.fromRGBO(244, 177, 101, 1);
  static const orange2 = Color.fromRGBO(238, 161, 92, 1);

  static const red1 = Color.fromRGBO(237, 101, 144, 1);
  static const red2 = Color.fromRGBO(235, 86, 115, 1);
}

abstract class LinearGradients {
  static final red = _buildGradient(
    CustomColors.red1,
    CustomColors.red2,
  );

  static final purple = _buildGradient(
    CustomColors.purple1,
    CustomColors.purple2,
  );

  static final orange = _buildGradient(
    CustomColors.orange1,
    CustomColors.orange2,
  );

  static final blue = _buildGradient(
    CustomColors.blue1,
    CustomColors.blue2,
  );

  static LinearGradient _buildGradient(Color color1, Color color2) =>
      LinearGradient(
        stops: const [0, 1],
        begin: Alignment.centerLeft,
        end: Alignment.bottomCenter,
        colors: [
          color1,
          color2,
        ],
      );
}
