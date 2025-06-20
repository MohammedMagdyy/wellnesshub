import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';
import 'package:wellnesshub/core/models/sign_up/userinfo_model.dart';


class SignupService {
  Future<Map<String, dynamic>> signup(String fname, String lname, String email, String password) async {
    try {
      final response = await API().post(
        url: 'http://10.0.2.2:8080/register',
        data: {
          'firstName': fname,
          'lastName': lname,
          'email': email,
          'password': password,
          // 'role': {
          //   'name': 'USER'
          // }
        },
        token: null,
      ).timeout(const Duration(seconds: 10));

      if (response != null && response['status'] == 'success') {
        return {'success': true, 'message': response['message'] ?? 'Signup successful'};
      } else {
        // Handle backend response with error message
        return {
          'success': false,
          'message': response['message'] ?? 'Signup failed. Please try again.'
        };
      }
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Server timeout. Please try again later.'
      };
    } on DioException catch (e) {
      // Handle Dio errors (network issues, etc.)
      String errorMessage = 'An error occurred. Please try again.';
      if (e.response != null) {
        if (e.response?.data is Map && e.response?.data['message'] != null) {
          errorMessage = e.response?.data['message'];
        } else if (e.response?.statusCode == 400) {
          errorMessage = 'Email already exists. Please use a different email.';
        }
      }
      return {
        'success': false,
        'message': errorMessage
      };
    } catch (e) {
      print('Unexpected error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred. Please try again.'
      };
    }
  }


  Future<Map<String, dynamic>> saveUserInfo(String email, UserInfo userinfo) async {
    try {
      final userInfoJson = userinfo.toJson();
      print('Sending user info: $userInfoJson');

      final response = await API().post(
        url: 'http://10.0.2.2:8080/saveUserInfo?userEmail=$email',
        data: userInfoJson,
      ).timeout(const Duration(seconds: 10)); // <-- Added timeout

      print('API Response: $response');

      if (response != null) {
        if (response['status'] == 'success') {
          return {'success': true, 'message': response['message'] ?? 'User info saved successfully'};
        } else {
          return {
            'success': false,
            'message': response['message'] ?? 'Failed to save user info',
            'statusCode': response['statusCode']
          };
        }
      }
      return {'success': false, 'message': 'No response from server'};
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Server timeout. Please try again later.'
      };
    } on DioException catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.response?.data}');
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Server error (${e.response?.statusCode})',
        'statusCode': e.response?.statusCode
      };
    } catch (e, stackTrace) {
      print('Error saving user info: $e\n$stackTrace');
      return {
        'success': false,
        'message': 'Failed to save user info: ${e.toString()}'
      };
    }
  }
}







