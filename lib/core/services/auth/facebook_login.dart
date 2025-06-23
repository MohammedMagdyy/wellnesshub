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
          //Save Email  response.data['email']
          String email=response.data['email'];
          print(email);
          await storage.saveUserEmail(email: email);
          return {'success': true, 'message': 'Continue user Info'};
        }
        await LocalStorageAccessToken.saveToken(jwt);
        debugPrint('✅ JWT Token stored: $jwt');
        return {'success': true, 'message': 'Login Success'};
      } else {
        debugPrint('❌ Backend login failed: ${response.statusMessage}');
        return {'success': false, 'message': 'Failed'};
      }
    } catch (e) {
      debugPrint('❌ Dio error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
