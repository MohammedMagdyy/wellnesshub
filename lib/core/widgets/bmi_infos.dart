import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

// ignore: must_be_immutable
class BmiInfos extends StatelessWidget {
  String label, value;
  BmiInfos({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isDark ? darkBmiTextColor_2 : lightBmiTextColor_2)),
        Text(label,
            style: TextStyle(
                color: isDark ? darkBmiTextColor_3 : lightBmiTextColor_3,
                fontSize: 15)),
      ],
    );
  }
}
