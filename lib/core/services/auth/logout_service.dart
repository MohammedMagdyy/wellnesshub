import 'package:wellnesshub/core/helper_class/localstorage.dart';

class LogoutService {
  Future<void> logout() async {
    LocalStorageAccessToken.removeToken();
  }
}
