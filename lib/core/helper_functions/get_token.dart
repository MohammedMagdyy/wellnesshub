import 'package:wellnesshub/core/helper_functions/localstorage.dart';

class GetToken {
  static Future<String?> getToken() async {
    LocalStorage.getToken();
  }
}
