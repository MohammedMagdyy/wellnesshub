import 'package:flutter/material.dart';import 'package:flutter/material.dart';

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
      cursorColor: Colors.lightBlue,
      cursorErrorColor: Colors.lightBlue,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.lightBlue)
        ),
        filled: readOnly,
        fillColor: readOnly ?
        (editable?
        (isDark? Colors.black: Colors.white)
        : (isDark ? const Color.fromARGB(124, 230, 230, 230)
          : const Color.fromARGB(124, 190, 190, 190))) : null,
      ),
    );
  }
}
