import 'package:flutter/material.dart';

class BmiInfos extends StatelessWidget {
  String label , value ;
  BmiInfos({super.key , required this.label , required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19 , color: Color(0xff0957DE))),
        Text(label, style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }
}