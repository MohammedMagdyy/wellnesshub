import '../helper_class/userInfo_local.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storage = UserInfoLocalStorage();


class GlobalVar {
  static final GlobalVar _instance = GlobalVar._internal();
  
  factory GlobalVar() => _instance;

  GlobalVar._internal();

  ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

  Future<void> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    isDarkModeNotifier.value = isDark;
  }

  Future<void> toggleDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final newMode = !isDarkModeNotifier.value;
    isDarkModeNotifier.value = newMode;
    await prefs.setBool('isDarkMode', newMode);
  }
}