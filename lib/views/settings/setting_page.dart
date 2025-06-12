import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_settingwidget.dart';
import 'package:wellnesshub/core/utils/global_var.dart';

// ignore: must_be_immutable
class SettingPage extends StatefulWidget {
  SettingPage({super.key});
  static const routeName = 'SettingPage';

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  void initState() {
    super.initState();
  }

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
                switchcheck: false,
                onTapFunc: 0,
                pageName: "WorkoutReminder",
              ),
              CustomSettingwidget(
                title: "Notification",
                icon: Icons.notifications_active,
                switchcheck: true,
                onTapFunc: 3,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Font Size",
                icon: Icons.font_download_rounded,
                switchcheck: false,
                onTapFunc: 2,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Select Language",
                icon: Icons.security,
                switchcheck: false,
                onTapFunc: 1,
                pageName: "SettingPage",
              ),
              CustomSettingwidget(
                title: "Dark Mode",
                icon: Icons.dark_mode,
                switchcheck: true,
                onTapFunc: 3,
                pageName: "SettingPage",
                isDarkModeSwitch: true,
              ),
              CustomSettingwidget(
                title: "Privacy Policy",
                icon: Icons.lock,
                switchcheck: false,
                onTapFunc: 0,
                pageName: "PrivacyPolicy",
              ),
              CustomSettingwidget(
                  title: "Profile Settings",
                  icon: Icons.person_pin_outlined,
                  switchcheck: false,
                  onTapFunc: 0,
                  pageName: "ProfilesettingsPage"),
              CustomSettingwidget(
                title: "App Info",
                icon: Icons.info,
                onTapFunc: 0,
                switchcheck: false,
                pageName: "AppinfoPage",
              ),
              CustomSettingwidget(
                  title: "Logout",
                  icon: Icons.logout,
                  switchcheck: false,
                  onTapFunc: 3,
                  pageName: "LoginPage"),
            ],
          ),
        ),
      ),
    );
  }
}
