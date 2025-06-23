import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

class CustomTextFieldProfile extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final bool readOnly;
  final bool editable;

  const CustomTextFieldProfile({
    super.key,
    required this.name,
    required this.controller,
    this.readOnly = false,
    this.editable = false
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      cursorColor: isDark? darkButtonTextColor : lightButtonTextColor,
      cursorErrorColor: isDark? darkButtonTextColor : lightButtonTextColor,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: TextStyle(color: isDark? darkButtonTextColor:lightButtonTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: isDark? darkCardBorderColor : lightCardBorderColor)
        ),
        filled: readOnly,
        fillColor: readOnly ?
        (editable?
        (isDark? Colors.black: Colors.white)
        : (isDark ? darkButtonColorInactive
          : lightButtonColorInactive)) : null,
      ),
    );
  }
}
