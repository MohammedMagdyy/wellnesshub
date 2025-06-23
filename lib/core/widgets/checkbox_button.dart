import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:wellnesshub/constant_colors.dart';

class CheckboxButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

   const CheckboxButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap, // Handle click
      child: Container(
        width: 350,
        height: 65,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected ? (isDark? darkImportantButtonEnd : lightImportantButtonEnd) : (isDark? darkButtonColorInactive : lightButtonColorInactive), // Change color
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 28,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: isSelected? (isDark? darkButtonTextColor : lightButtonTextColor) : (isDark? darkButtonTextInactiveColor : lightButtonTextInactiveColor),
                fontWeight: FontWeight.bold,
              ),
            ),
            RoundCheckBox(
              onTap: null, // Checkbox follows button state
              size: 30,
              isChecked: isSelected, // Check when selected
            ),
          ],
        ),
      ),
    );
  }
}
