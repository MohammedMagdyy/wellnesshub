import 'package:flutter/material.dart';
import 'package:wellnesshub/views/height_page.dart';
import 'package:wellnesshub/views/sign_in.dart';
import 'package:wellnesshub/views/sign_up.dart';
import 'package:wellnesshub/views/startup.dart';

void main(){
  runApp(WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage':(context)=>Sign_In(),
        'SignUpPage':(context)=>Sign_Up(),
        'StartUp':(context)=>Startup(),
        // 'LoginPage':(context)=>Sign_In(),
      },
      debugShowCheckedModeBanner: false,
      home: HeightPage(),
    );
  }
}