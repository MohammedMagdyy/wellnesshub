import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';
import 'package:wellnesshub/core/helper_class/localstorage.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<bool> login(String email, String password) async {
    final response = await API()
        .post(url: 'url', data: {'email': email, 'password': password});
    if (response.statusCode == 200 && response.data['token'] != null) {
      LocalStorage.saveToken(response.data['token']);
      return true;
    }
    return false;
  }
}

/*
 try {
      final response = await _dio.post(
        'https://your-backend.com/api/login', 
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        LocalStorage.saveToken(response.data['token']);
        return true;
      }
    } on DioException catch (e) {
      print("Login error: ${e.response?.data ?? e.message}");
    }
    return false;
*/
