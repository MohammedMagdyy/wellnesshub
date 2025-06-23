import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_settingwidget.dart';
import '../../core/services/getUserInfo_service.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});
  static const String routeName = 'ProfilesettingsPage';

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  late Future<dynamic> _userInfoFuture;

  @override
  void initState() {
    super.initState();
    _userInfoFuture = GetUserInfoService().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Account"),
      body: SafeArea(
        child: FutureBuilder<dynamic>(
          future: _userInfoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final response = snapshot.data;

              return ListView(
                children: [
                  const CustomSettingwidget(
                    title: "Profile Details",
                    icon: Icons.person,
                    switchcheck: false,
                    pageName: "Profile",
                  ),
                  const CustomSettingwidget(
                    title: "Delete Account",
                    icon: Icons.delete,
                    switchcheck: false,
                    onTapFunc: 4,
                    pageName: "LoginPage",
                  ),
                  if (response.provider != "GOOGLE" &&
                      response.provider != "FACEBOOK")
                    const CustomSettingwidget(
                      title: "Change Password",
                      icon: Icons.password_rounded,
                      switchcheck: false,
                      pageName: "ChangePasswordPage",
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
