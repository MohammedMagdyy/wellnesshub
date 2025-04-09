import 'package:flutter/material.dart';
import 'package:wellnesshub/core/helper_functions/on_generate_route.dart';
import 'package:wellnesshub/views/about_us_page.dart';
import 'package:wellnesshub/views/appinfo_page.dart';
import 'package:wellnesshub/views/changepassword_page.dart';
import 'package:wellnesshub/views/profilesettings_page.dart';
import 'package:wellnesshub/views/rate_app.dart';
import 'package:wellnesshub/views/setting_page.dart';
import 'package:wellnesshub/views/signup_process/sign_up.dart';
import 'package:wellnesshub/views/splash_screen.dart';


void main() {
  runApp(WellnessHub());
}

class WellnessHub extends StatelessWidget {
  const WellnessHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: OnGenerateRoute,
      initialRoute: SettingPage.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
color: Theme.of(context).brightness == Brightness.dark
    ? Colors.white
    : Colors.black

*/
