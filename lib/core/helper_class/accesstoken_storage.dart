import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageAccessToken {
  //final prefs = await SharedPreferences.getInstance();
  static Future<void> saveToken(String token) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
