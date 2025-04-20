import 'package:wellnesshub/core/helper_class/localstorage.dart';

class GetToken {
  static Future<String?> getToken() async {
    LocalStorage.getToken();
    return null;
  }
}
