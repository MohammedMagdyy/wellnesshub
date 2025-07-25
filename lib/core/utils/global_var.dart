import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../helper_class/userInfo_local.dart';

final String apiUrl='https://wellness-production.up.railway.app';
//http://10.0.2.2:8080
final storage = UserInfoLocalStorage(); // Assuming you use this elsewhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ValueNotifier<File?> profileImageNotifier = ValueNotifier<File?>(null);
//ValueNotifier<int> profileImageVersionNotifier = ValueNotifier<int>(0);
final ValueNotifier<int> profileImageVersionNotifier = ValueNotifier(0);

ValueNotifier<String> userNameNotifier = ValueNotifier<String>("User");
bool googleFlag = false;
bool facebookFlag = false;

class GlobalVar {
  static final GlobalVar _instance = GlobalVar._internal();

  factory GlobalVar() => _instance;

  GlobalVar._internal();

  late SharedPreferences _prefs;
  ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> loadDarkMode() async {
    final isDark = _prefs.getBool('isDarkMode') ?? false;
    isDarkModeNotifier.value = isDark;
  }

  Future<void> toggleDarkMode() async {
    final newMode = !isDarkModeNotifier.value;
    isDarkModeNotifier.value = newMode;
    await _prefs.setBool('isDarkMode', newMode);
  }

  Future<void> loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null && File(imagePath).existsSync()) {
      profileImageNotifier.value = File(imagePath);
    } else {
      profileImageNotifier.value = null;
    }

    print("done loading image");
  }


  Future<void> saveEmailForRestoredPassword(String email) async {
    await _prefs.setString('email', email);
  }

  Future<String?> getEmailForRestoredPassword() async {
    return _prefs.getString('email');
  }
}



