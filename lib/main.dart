import 'package:flutter/material.dart';
import 'package:wellnesshub/core/helper_functions/on_generate_route.dart';
import 'package:wellnesshub/core/utils/global_var.dart';
import 'package:wellnesshub/views/exercise_page.dart';
import 'package:wellnesshub/views/progress.dart';
import 'package:wellnesshub/views/sign_in.dart';
import 'package:wellnesshub/views/challenges/challenge_plank.dart';
import 'package:wellnesshub/views/challenges/challenge_pushups.dart';
import 'package:wellnesshub/views/challenges/challenge_squats.dart';
import 'package:wellnesshub/views/mainpage.dart';
import 'package:wellnesshub/views/signup_process/meal_plan.dart';
import 'package:wellnesshub/views/signup_process/verify_email_page.dart';
import 'package:wellnesshub/views/signup_process/activity_page.dart';
import 'package:wellnesshub/views/signup_process/meal_plan.dart';
import 'package:wellnesshub/views/signup_process/sign_up.dart';
import 'package:wellnesshub/views/fitnessplanpage.dart';
import 'package:wellnesshub/views/fullbodyexercise_page.dart';
import 'package:wellnesshub/views/setting_page.dart';
import 'package:wellnesshub/views/signup_process/verify_email_page.dart';
import 'package:wellnesshub/views/test.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalVar().loadDarkMode();
  runApp(WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlobalVar().isDarkModeNotifier,
      builder: (context, value, child) {
        final bool isDarkMode = value;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: OnGenerateRoute,
          initialRoute: MainPage.routeName,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            brightness: Brightness.light
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            brightness: Brightness.dark
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}

