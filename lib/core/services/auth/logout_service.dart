import 'package:wellnesshub/core/helper_class/accesstoken_storage.dart';

class LogoutService {
  Future<void> logout() async {
    LocalStorageAccessToken.removeToken();
  }
}
