import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper_class/userInfo_local.dart';

final storage = UserInfoLocalStorage(); // Assuming you use this elsewhere

class GlobalVar {
  static final GlobalVar _instance = GlobalVar._internal();

  factory GlobalVar() => _instance;

  GlobalVar._internal();

  late SharedPreferences _prefs;

  // Notifier for dark mode updates
  ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Load dark mode state from SharedPreferences
  Future<void> loadDarkMode() async {
    final isDark = _prefs.getBool('isDarkMode') ?? false;
    isDarkModeNotifier.value = isDark;
  }

  /// Toggle dark mode and persist the change
  Future<void> toggleDarkMode() async {
    final newMode = !isDarkModeNotifier.value;
    isDarkModeNotifier.value = newMode;
    await _prefs.setBool('isDarkMode', newMode);
  }

  /// Save email for password reset flow
  Future<void> saveEmailForRestoredPassword(String email) async {
    await _prefs.setString('email', email);
  }

  /// Retrieve saved email for password reset
  Future<String?> getEmailForRestoredPassword() async {
    return _prefs.getString('email');
  }
}
