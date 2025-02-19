import 'package:flutter/material.dart';
import 'package:wellnesshub/views/startup.dart';

void main(){
  runApp(WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Startup(),
    );
  }
}