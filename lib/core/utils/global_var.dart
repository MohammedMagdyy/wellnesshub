import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../helper_class/userInfo_local.dart';

final storage = UserInfoLocalStorage(); // Assuming you use this elsewhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ValueNotifier<File?> profileImageNotifier = ValueNotifier<File?>(null);

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



// class GlobalVar {
//   static final GlobalVar _instance = GlobalVar._internal();
//
//   factory GlobalVar() => _instance;
//
//   GlobalVar._internal();
//
//   late SharedPreferences _prefs;
//
//   // Notifier for dark mode updates
//   ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);
//
//   /// Initialize SharedPreferences
//   Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   /// Load dark mode state from SharedPreferences
//   Future<void> loadDarkMode() async {
//     final isDark = _prefs.getBool('isDarkMode') ?? false;
//     isDarkModeNotifier.value = isDark;
//   }
//
//   /// Toggle dark mode and persist the change
//   Future<void> toggleDarkMode() async {
//     final newMode = !isDarkModeNotifier.value;
//     isDarkModeNotifier.value = newMode;
//     await _prefs.setBool('isDarkMode', newMode);
//   }
//
//   /// Save email for password reset flow
//   Future<void> saveEmailForRestoredPassword(String email) async {
//     await _prefs.setString('email', email);
//   }
//
//   /// Retrieve saved email for password reset
//   Future<String?> getEmailForRestoredPassword() async {
//     return _prefs.getString('email');
//   }
// }
