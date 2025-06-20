import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';
import 'package:wellnesshub/core/helper_class/accesstoken_storage.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await API().post(
        url: 'http://10.0.2.2:8080/login',
        data: {'email': email, 'password': password},
        token: null,
      ).timeout(const Duration(seconds: 10)); // <-- Added timeout

      if (response != null && response['accessToken'] != null) {
        await LocalStorageAccessToken.saveToken(response['accessToken']);
        return {'success': true, 'message': 'Login successful'};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Invalid credentials'
      };
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Server timeout. Please try again later.'
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Login failed due to a server error.'
      };
    } catch (e) {
      print('Unexpected error: $e');
      return {'success': false, 'message': 'Unexpected error occurred'};
    }
  }
}
