import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.name,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.isProfile = false,
  });

  final String name;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isProfile;


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field is required';
        }
        return null;
      },

      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.name,
        labelStyle: TextStyle(color: isDark? darkChatInputTextColor : lightChatInputTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: isDark? darkChatInputBarEnabledBorderColor : lightChatInputBarEnabledBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: isDark? darkChatInputBarFocusedBorderColor : lightChatInputBarFocusedBorderColor,
              width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: isDark? darkChatInputBarEnabledBorderColor : lightChatInputBarEnabledBorderColor, width: 1),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: isDark? darkSettingsArrowsColor:lightSettingsArrowsColor,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
    );
  }
}
