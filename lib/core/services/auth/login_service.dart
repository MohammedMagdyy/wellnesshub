import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';
import 'package:wellnesshub/core/helper_class/accesstoken_storage.dart';

import '../../helper_class/network_exception_class.dart';
import '../../utils/global_var.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await API().post(
        url: '$apiUrl/login',
        data: {'email': email, 'password': password},
        token: null,
      );

      // Successful response handling
      if (response is Map && response['accessToken'] != null) {
        await LocalStorageAccessToken.saveToken(response['accessToken']);
        return {'success': true, 'message': 'Login successful'};
      }
      else if(response['statusCode']=='BAD_REQUEST'||response['statusCode']=='NOT_FOUND'){
        return {'success': false, 'message': response['message']};
      }

      return {
        'success': false,
        'message': 'Invalid server response format'
      };
    } on NetworkException catch (e) {
      // Handle specific network-related errors
      return {'success': false, 'message': e.message};
    }on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        dynamic errorData = e.response?.data;

        String message = 'Login failed';

        try {
          if (errorData is String) {
            errorData = jsonDecode(errorData); // force decode string to Map
          }
          if (errorData is Map) {
            message = errorData['message'] ?? errorData['error'] ?? message;
          }
        } catch (e) {
          print('Failed to decode error message: $e');
        }

        if (statusCode == 404) {
          return {'success': false, 'message': 'Email not found'};
        } else if (statusCode == 400) {
          return {'success': false, 'message': message};
        }

        return {'success': false, 'message': message};
      }

      return {'success': false, 'message': 'Network error: ${e.message}'};
    }
    catch (e) {
      print('2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      print('Unexpected error in LoginService: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }
}

