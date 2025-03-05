import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_settingwidget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: Text('Settings'),

        titleSpacing: 100,
      ),
      body: Column(
        children: [
          CustomSettingwidget(
            title:"Set Workout Reminders",
          icon:Icons.notifications_none,
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
          ),
          CustomSettingwidget(
            title: "Edit Profile Details",
          icon: Icons.person_pin_outlined,
          check: true,
          ),
          
          CustomSettingwidget(
              title: "Logout",
            icon: Icons.logout,
            check: true,
            ),
          
        ],
      ),
    );
  }
}

