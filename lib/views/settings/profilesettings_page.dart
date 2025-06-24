import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_settingwidget.dart';
import '../../core/models/sign_up/full_userinfo_model.dart';
import '../../core/services/getUserInfo_service.dart';


class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});
  static const String routeName = 'ProfilesettingsPage';

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  FullUserInfo? _userInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final info = await GetUserInfoService().getUserInfo();
      setState(() {
        _userInfo = info;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('❌ Failed to load user info: $e');
      setState(() => _isLoading = false); // Still show the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Account"),
      body: SafeArea(
        child: ListView(
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

            // Conditionally show change password if provider is not Google/Facebook
            if (!_isLoading &&
                _userInfo != null &&
                _userInfo!.provider != "GOOGLE" &&
                _userInfo!.provider != "FACEBOOK")
              const CustomSettingwidget(
                title: "Change Password",
                icon: Icons.password_rounded,
                switchcheck: false,
                pageName: "ChangePasswordPage",
              ),
          ],
        ),
      ),
    );
  }
}
