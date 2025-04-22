import 'package:shared_preferences/shared_preferences.dart';
class IsLoggedin {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }
}

