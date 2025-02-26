import 'package:flutter/material.dart';
import 'package:wellnesshub/views/activity_page.dart';
import 'package:wellnesshub/views/community_page.dart';
import 'package:wellnesshub/views/gender_page.dart';
import 'package:wellnesshub/views/goal_page.dart';
import 'package:wellnesshub/views/injuries_page.dart';
import 'package:wellnesshub/views/nutrition_page.dart';
import 'package:wellnesshub/views/physical_page.dart';
import 'package:wellnesshub/views/setting_page.dart';
import 'package:wellnesshub/views/sign_in.dart';
import 'package:wellnesshub/views/sign_up.dart';
import 'package:wellnesshub/views/startup.dart';
import 'package:wellnesshub/views/weight_page.dart';
import 'package:wellnesshub/views/year_page.dart';

void main() {
  runApp(WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'StartUp': (context) => Startup(),
        'LoginPage': (context) => SignIn(),
        'SignUpPage': (context) => SignUp(),
        'GenderPage': (context) => GenderPage(),
        'GoalPage': (context) => GoalPage(),
        'PhysicalPage': (context) => PhysicalPage(),
        'InjuriesPage': (context) => InjuriesPage(),
        'ActivityPage': (context) => ActivityPage(),

        'AgePage': (context) => YearPage(),
        'WeightPage': (context) => WeightPage(),
        'CommunityPage': (context) => CommunityPage(),
        'NutritionPage': (context) => NutritionPage(),
        'SettingPage': (context) => SettingPage(),
        // 'SettingPage': (context) => SettingPage(),

      
      },
      debugShowCheckedModeBanner: false,
      home: SettingPage(),
    );
  }
}
