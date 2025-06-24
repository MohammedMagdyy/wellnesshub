import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dio/dio.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../utils/global_var.dart';

class FacebookLoginService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final token = result.accessToken!.token;
        final backendResult = await _loginToBackend(token);
        return backendResult;
      } else {
        debugPrint('Facebook login failed: ${result.message}');
        return {'success': false, 'message': 'Failed'};
      }
    } catch (e) {
      debugPrint('Facebook login error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> _loginToBackend(String fbAccessToken) async {
    try {
      final response = await _dio.post(
        '$apiUrl/facebook/login',
        data: {'accessToken': fbAccessToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final jwt = response.data['accessToken'];
        if (jwt == null) {
          String email = response.data['email'];
          print(email);
          await storage.saveUserEmail(email: email);
          return {'success': true, 'message': 'Continue user Info'};
        }
        await LocalStorageAccessToken.saveToken(jwt);
        return {'success': true, 'message': 'Login Success'};
      } else {
        // Optional fallback (shouldn’t happen if DioException is triggered for errors)
        return {'success': false, 'message': response.statusMessage ?? 'Login failed'};
      }
    } on DioException catch (e) {
      String message = 'Login failed';

      try {
        dynamic errorData = e.response?.data;

        if (errorData is String) {
          errorData = jsonDecode(errorData);
        }

        if (errorData is Map && errorData['message'] != null) {
          message = errorData['message'];
        } else if (e.response?.statusCode == 401) {
          message = 'Unauthorized Facebook login: Invalid or expired token.';
        } else if (e.response?.statusCode == 404) {
          message = 'Not Found: This Email may be registered via another provider';
        }
      } catch (err) {
        debugPrint('Error decoding backend error: $err');
        message = 'Failed  Error';
      }

      return {'success': false, 'message': message};
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: ${e.toString()}'};
    }
  }



}
