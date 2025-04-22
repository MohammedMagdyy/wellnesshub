import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_settingwidget.dart';

class ProfilesettingsPage extends StatelessWidget {
  const ProfilesettingsPage({super.key});
  static const String routeName = 'ProfilesettingsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Account"),
      body: SafeArea(
        child: ListView(
          children: const [
            CustomSettingwidget(
              title: "Change Password",
              icon: Icons.password_rounded,
              check: true,
              pageName: "ChangepasswordPage",
            ),
            CustomSettingwidget(
              title: "Profile Details",
              icon: Icons.person,
              check: true,
              pageName: "Profile",
            ),
            CustomSettingwidget(
              title: "Delete Account",
              icon: Icons.delete,
              check: true,
              pageName: "RateAppPage",
            ),
          ],
        ),
      ),
    );
  }
}
