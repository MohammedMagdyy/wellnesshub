import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.name,
      this.onChanged,
      this.keyboardtype,
      this.obscureText = false});

  final String name;
  final Function(String)? onChanged;
  final TextInputType? keyboardtype;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      onChanged: onChanged,
      keyboardType: keyboardtype,
      obscureText: obscureText,

      //keyboardAppearance: Brightness.dark,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.blue, width: 1),
        ),
      ),
    );
  }
}
