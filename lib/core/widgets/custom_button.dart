import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.name,
    required this.on_Pressed,
    required this.width,
    required this.color,
    this.isLoading = false,
  });

  final String name;
  final VoidCallback? on_Pressed;
  final double width;
  final Color color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 50,
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : on_Pressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark? darkImportantButtonStart : lightImportantButtonStart,
          disabledBackgroundColor: isDark? darkButtonColorInactive : lightButtonColorInactive,
        ),
        child: isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 3,
          ),
        )
            : Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
