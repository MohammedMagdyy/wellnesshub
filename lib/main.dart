import 'package:flutter/material.dart';
import 'package:wellnesshub/core/helper_functions/on_generate_route.dart';
import 'package:wellnesshub/core/utils/global_var.dart';
import 'package:wellnesshub/views/settings/changepassword_page.dart';
import 'package:wellnesshub/views/exercisedetails_page.dart';
import 'package:wellnesshub/views/login_process/find_your_account.dart';
import 'package:wellnesshub/views/login_process/forgetpassword_page.dart';
import 'package:wellnesshub/views/progress.dart';
import 'package:wellnesshub/views/login_process/sign_in.dart';
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
import 'package:wellnesshub/views/settings/setting_page.dart';
import 'package:wellnesshub/views/signup_process/verify_email_page.dart';
import 'package:wellnesshub/views/splash_screen.dart';
import 'package:wellnesshub/views/test.dart';

import 'core/helper_class/Dio_Interceptor _Handling401.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalVar().init();
  await GlobalVar().loadDarkMode();
  await GlobalVar().loadProfileImage();
  final dioInterceptor = DioInterceptorHandlingError();
  dioInterceptor.setupDio();
  runApp(const WellnessHub());
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
          navigatorKey: navigatorKey,
          onGenerateRoute: OnGenerateRoute,
          initialRoute:SplashScreen.routeName,
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

