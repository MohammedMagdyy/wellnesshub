import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  CustomToggleSwitch({super.key});
  static const routeName = 'CustomToggleSwitch';
  

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isToggled,
      onChanged: (value) {
        setState(() {
          isToggled = value;
          print(value);
        });
      },
      activeColor: Colors.white, // Thumb color when ON
      activeTrackColor: Colors.blue, // Track color when ON
      inactiveThumbColor: Colors.blueAccent, // Thumb color when OFF
      inactiveTrackColor: Colors.white, // Track color when OFF
    );
  }
}
