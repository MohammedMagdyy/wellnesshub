import 'package:flutter/material.dart';import 'package:flutter/material.dart';

class CustomTextFieldProfile extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final bool readOnly;

  const CustomTextFieldProfile({
    super.key,
    required this.name,
    required this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        filled: readOnly,
        fillColor: readOnly ? Colors.grey[200] : null, // Optional: light background
      ),
    );
  }
}
