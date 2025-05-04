import 'package:flutter/material.dart';
import 'package:wellnesshub/core/helper_functions/on_generate_route.dart';
import 'package:wellnesshub/views/progress.dart';
import 'package:wellnesshub/views/sign_in.dart';
import 'package:wellnesshub/views/challenges/challenge_plank.dart';
import 'package:wellnesshub/views/challenges/challenge_pushups.dart';
import 'package:wellnesshub/views/challenges/challenge_squats.dart';
import 'package:wellnesshub/views/mainpage.dart';
import 'package:wellnesshub/views/signup_process/activity_page.dart';
import 'package:wellnesshub/views/signup_process/meal_plan.dart';
import 'package:wellnesshub/views/signup_process/sign_up.dart';
import 'package:wellnesshub/views/signup_process/verify_email_page.dart';


void main() {
  runApp(WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: OnGenerateRoute,
      initialRoute: VerifyEmailPage.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
color: Theme.of(context).brightness == Brightness.dark
    ? Colors.white
    : Colors.black

*/
