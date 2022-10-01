import 'dart:ui';
import 'package:flutter/material.dart';

class Cost extends StatelessWidget {
  final Color color;
  final double cost;
  const Cost({Key? key, required this.color, required this.cost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '\$',
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontFeatures: const [
              FontFeature.superscripts(),
            ],
          ),
        ),
        const SizedBox(width: 3),
        Text(
          cost.toInt().toString(),
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          (cost - cost.toInt()).toStringAsFixed(2),
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFeatures: const [
              FontFeature.superscripts(),
            ],
          ),
        ),
      ],
    );
  }
}
