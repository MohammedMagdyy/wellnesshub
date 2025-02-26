
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class SpecialCheckboxbutton extends StatelessWidget {
     const SpecialCheckboxbutton({
    super.key,
    required this.text1,
    required this.text2,
    required this.isSelected,
    required this.onTap,
  });
  
  final String text1;
  final String text2;
  final bool isSelected;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle click
      child: Container(
        width: 350,
        height: 75,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected ? Colors.blue : Colors.grey, // Change color
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 28,
            ),
            Column(
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            RoundCheckBox(
              onTap: null, // Checkbox follows button state
              size: 30,
              isChecked: isSelected, // Check when selected
            ),
          ],
        ),
      ),
    );
  }
}