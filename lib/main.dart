import 'package:flutter/material.dart';
import 'package:wellnesshub/views/gender_page.dart';
import 'package:wellnesshub/views/goal_page.dart';
import 'package:wellnesshub/views/sign_in.dart';
import 'package:wellnesshub/views/sign_up.dart';
import 'package:wellnesshub/views/startup.dart';
import 'package:wellnesshub/widgets/checkbox_button.dart';

void main(){
  runApp(WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage':(context)=>SignIn(),
        'SignUpPage':(context)=>SignUp(),
        'StartUp':(context)=>Startup(),
        'GenderPage':(context)=>GenderPage(),
        'GoalPage':(context)=>GoalPage(),

        // 'LoginPage':(context)=>Sign_In(),
      },
      debugShowCheckedModeBanner: false,
      home: GoalPage(),
    );
  }
}