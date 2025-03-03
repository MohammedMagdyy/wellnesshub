import 'package:flutter/material.dart';
import 'package:wellnesshub/views/signup_process/activity_page.dart';
import 'package:wellnesshub/views/community_page.dart';
import 'package:wellnesshub/views/signup_process/gender_page.dart';
import 'package:wellnesshub/views/signup_process/goal_page.dart';
import 'package:wellnesshub/views/signup_process/height_page.dart';
import 'package:wellnesshub/views/signup_process/injuries_page.dart';
import 'package:wellnesshub/views/nutrition_page.dart';
import 'package:wellnesshub/views/signup_process/physical_page.dart';
import 'package:wellnesshub/views/setting_page.dart';
import 'package:wellnesshub/views/sign_in.dart';
import 'package:wellnesshub/views/signup_process/sign_up.dart';
import 'package:wellnesshub/views/startup.dart';
import 'package:wellnesshub/views/signup_process/verify_email_page.dart';
import 'package:wellnesshub/views/signup_process/weight_page.dart';
import 'package:wellnesshub/views/signup_process/year_page.dart';
import 'package:wellnesshub/views/favorites.dart';
import 'package:wellnesshub/views/privacypolicy.dart';
import 'package:wellnesshub/views/profile.dart';
import 'package:wellnesshub/views/signup_process/meal_plan.dart';

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
        'MealPlan': (context) => MealPlan(),

        'AgePage': (context) => YearPage(),
        'WeightPage': (context) => WeightPage(),
        'HeightPage' :(context) => HeightPage(),

        'CommunityPage': (context) => CommunityPage(),
        'NutritionPage': (context) => NutritionPage(),


        'SettingPage': (context) => SettingPage(),
        'Favorites' :(context) => Favorites(),
        'PrivacyPolicy' :(context) => PrivacyPolicyPage(),
        'Profile' :(context) => Profile(),
        'VerifyEmailPage' : (context) => VerifyEmailPage(),
      },
      debugShowCheckedModeBanner: false,
      home: Startup(),
    );
  }
}
