import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

class ProfileInfoCard extends StatelessWidget {
  final String value, label;
  const ProfileInfoCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,
        color: isDark? darkPrimaryTextColor :lightPrimaryTextColor
        )),
        Text(label, style: TextStyle(fontSize: 12, color:isDark? darkSecondaryTextColor:lightSecondaryTextColor)),
      ],
    );
  }
}
