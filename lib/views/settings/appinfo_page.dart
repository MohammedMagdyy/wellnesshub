import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_settingwidget.dart';

class AppinfoPage extends StatelessWidget {
  const AppinfoPage({super.key});
  static const String routeName = 'AppinfoPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "App Info"),
      body: SafeArea(
        child: ListView(
          children: const [

            CustomSettingwidget(
              title: "Version Info",
              icon: Icons.insert_drive_file_outlined,
              switchcheck: false,
              pageName: "VersionInfoPage",
            ),
            CustomSettingwidget(
              title: "About Us",
              icon: Icons.group,
              switchcheck: false,
              pageName: "AboutUsPage",
            ),
            CustomSettingwidget(
              title: "Rate Our App",
              icon: Icons.rate_review,
              switchcheck: false,
              pageName: "RateAppPage",
            ),
          ],
        ),
      ),
    );
  }
}
