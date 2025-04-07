import 'package:wellnesshub/core/helper_functions/localstorage.dart';

class LogoutService {
  Future<void> logout() async {
    LocalStorage.removeToken();
  }
}
