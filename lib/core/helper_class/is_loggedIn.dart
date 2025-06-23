import 'package:shared_preferences/shared_preferences.dart';
class IsLoggedin {
   Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }
}

