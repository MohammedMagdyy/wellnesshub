import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class CheckboxButton extends StatelessWidget {
  const CheckboxButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 65,
      margin: EdgeInsets.all(10), // ✅ Added margin to container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blue, // ✅ Moved inside BoxDecoration
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20), // ✅ Added padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ Proper alignment
        children: [
          Text(
            "HELLOOOOOOOOOOOO",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white, // ✅ Improved readability
              fontWeight: FontWeight.bold,
            ),
          ),
          RoundCheckBox(
            onTap: (selected) {},
            size: 30, // ✅ Adjust size
            uncheckedColor: Colors.white, // ✅ Make it visible on blue
            checkedColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
