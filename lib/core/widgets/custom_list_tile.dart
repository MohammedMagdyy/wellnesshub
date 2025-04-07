import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key, required this.text, required this.image, this.on_Pressed});
  final String text;
  final String image;
  VoidCallback? on_Pressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color:  const Color.fromARGB(127, 158, 158, 158)),
      child: ListTile(
        visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
        dense: true,
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xff0065d0),
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
