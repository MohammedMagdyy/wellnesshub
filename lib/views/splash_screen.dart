import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = 'Splash_Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  bool logedIn = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1 , milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    _fadeController.forward();
    _slideController.forward();

    Future.delayed(
      const Duration(seconds: 6),
      () {
        logedIn
            ? Navigator.pushReplacementNamed(context, "MainPage")
            : Navigator.pushReplacementNamed(context, "LoginPage");
      },
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                Assets.assetsImagesIntrobackground,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 400,
                left: 0,
                right: 0,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Center(
                    child: Text(
                      'Welcome to WellnessHub',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}