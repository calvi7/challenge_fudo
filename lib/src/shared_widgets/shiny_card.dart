import 'package:challenge_fudo/src/utils/shiny_card_style.dart';
import 'package:flutter/material.dart';

class ShinyCard extends StatelessWidget {
  const ShinyCard({
    super.key,
    required this.data,
    required this.child,
  });

  final Widget child;
  final ShinyCardStyle data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: data.shadowColor.withOpacity(0.9),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          const BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //Box
        ],
        gradient: data.gradient,
      ),
      child: child,
    );
  }
}
