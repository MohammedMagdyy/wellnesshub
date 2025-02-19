import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
CustomButton({super.key, required this.name, this.on_Pressed});
  final String name;
  VoidCallback? on_Pressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      child: ElevatedButton(onPressed: on_Pressed, child: Text(name)),
    );
  }
}