import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

class MealPlanSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const MealPlanSection({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
              color: isDark?darkPrimaryTextColor : lightPrimaryTextColor
          )),
          Column(
            children: options.map((option) {
              return RadioListTile<String>(
                title: Text(option , style: TextStyle(
                  color:
                  isDark? darkSecondaryTextColor : lightSecondaryTextColor,
                ),),
                value: option,
                groupValue: selectedValue,
                onChanged: onChanged,
                activeColor: isDark? darkAppbarBackArrowColor:lightAppbarBackArrowColor,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
