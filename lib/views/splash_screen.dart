import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = 'Splash_Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool logedIn = false ;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds:5 ),
      () {
        logedIn?
        Navigator.pushReplacementNamed(context, "MainPage") :
        Navigator.pushReplacementNamed(context, "LoginPage");
      },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Image.asset(Assets.assetsImagesIntrobackground)),
      );
  }
}