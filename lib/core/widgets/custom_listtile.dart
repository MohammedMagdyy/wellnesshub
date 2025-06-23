import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key, required this.text, required this.image, this.on_Pressed});
  final String text;
  final String image;
  VoidCallback? on_Pressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isDark? darkButtonColor : lightButtonColor
      ),
      child: ListTile(
        visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
        dense: true,
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark? darkButtonTextColor : lightButtonTextColor,
          ),
        ),
        leading: Image.asset(
          image,
        ),
        onTap: on_Pressed,
      ),
    );
  }
}
/*
Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        minTileHeight: 30,
        visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
        // dense: true,
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        leading: Image.asset(
          image,
        ),
        onTap: on_Pressed,
      ),
    );
*/
