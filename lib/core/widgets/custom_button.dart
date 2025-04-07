import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.name, this.on_Pressed, required this.width, required this.color});
  final String name;
  VoidCallback? on_Pressed;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      width: width,
      //color: Colors.blue,

      child: ElevatedButton(
        onPressed: on_Pressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Set background color to blue
        ),
        child: Text(
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
