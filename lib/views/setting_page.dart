import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_settingwidget.dart';


class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  static const routeName = 'SettingPage';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            CustomSettingwidget(
              title: "Set Workout Reminders",
              icon: Icons.notifications_none,
              check: true,
            ),
            CustomSettingwidget(
              title: "Enable Location Services",
              icon: Icons.location_on_outlined,
              check: true,
            ),
            CustomSettingwidget(
              title: "Dark Mode",
              icon: Icons.dark_mode,
              check: true,
            ),
            CustomSettingwidget(
              title: "Privacy Policy",
              icon: Icons.lock,
              check: true,
              pageName: "PrivacyPolicy",
            ),
            CustomSettingwidget(
              title: "Edit Profile Details",
              icon: Icons.person_pin_outlined,
              check: true,
              pageName: "Profile"
            ),
            CustomSettingwidget(
              title: "Logout",
              icon: Icons.logout,
              check: true,
              pageName: "LoginPage"
            ),
          ],
        ),
      ),
    );
  }
}

