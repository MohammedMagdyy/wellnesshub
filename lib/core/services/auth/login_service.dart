import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';
import 'package:wellnesshub/core/helper_class/accesstoken_storage.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await API().post(
        url: 'https://wellness-production.up.railway.app/login',
        data: {'email': email, 'password': password},
        token: null,
      );

      if (response != null && response['accessToken'] != null) {
        await LocalStorageAccessToken.saveToken(response['accessToken']);
        return {'success': true, 'message': 'Login successful'};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Invalid credentials'
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ??
            'Login failed due to a server error.'
      };
    } catch (e) {
      print('Unexpected error: $e');
      return {'success': false, 'message': 'Unexpected error occurred'};
    }
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
