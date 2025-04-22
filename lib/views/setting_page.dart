import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_settingwidget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  static const routeName = 'SettingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Settings"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView(
            children: const [
              CustomSettingwidget(
                title: "Set Workout Reminders",
                icon: Icons.notifications_none,
                check: true,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Notification",
                icon: Icons.notifications_active,
                check: true,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Font Size",
                icon: Icons.font_download_rounded,
                check: true,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Security",
                icon: Icons.security,
                check: true,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Select Language",
                icon: Icons.security,
                check: true,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Enable Location Services",
                icon: Icons.location_on_outlined,
                check: true,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Dark Mode",
                icon: Icons.dark_mode,
                check: true,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Privacy Policy",
                icon: Icons.lock,
                check: true,
                pageName: "PrivacyPolicy",
              ),
              CustomSettingwidget(
                  title: "Profile Settings",
                  icon: Icons.person_pin_outlined,
                  check: true,
                  pageName: "ProfilesettingsPage"),
              CustomSettingwidget(
                title: "App Info",
                icon: Icons.info,
                check: true,
                pageName: "AppinfoPage",
              ),
              CustomSettingwidget(
                  title: "Logout",
                  icon: Icons.logout,
                  check: true,
                  pageName: "LoginPage"),
            ],
          ),
        ),
      ),
    );
  }
}
