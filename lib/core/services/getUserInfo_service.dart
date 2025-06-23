import 'dart:async';
import '../helper_class/accesstoken_storage.dart';
import '../helper_class/api.dart';
import '../helper_class/network_exception_class.dart';
import '../models/sign_up/full_userinfo_model.dart';
import '../utils/global_var.dart';

class GetUserInfoService {
  Future<FullUserInfo> getUserInfo() async {
    try {
      final token = await LocalStorageAccessToken.getToken();
      final response = await API().get(
        url: '$apiUrl/getUserInfo',
        token: token,
      );

      final data = response;

      if (data is Map<String, dynamic>) {
        return FullUserInfo.fromJson(data);
      } else {
        throw FormatException('Unexpected response format: $data');
      }
    } catch (e, stackTrace) {
      print('Unexpected error: $e\n$stackTrace');
      throw NetworkException('An unexpected error occurred: ${e.toString()}');
    }
  }
}

