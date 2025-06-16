import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookLoginService {
  final Dio _dio = Dio();

  Future<void> loginWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final token = result.accessToken!.token;
        await _loginToBackend(context, token);
      } else {
        debugPrint('Facebook login failed: ${result.message}');
      }
    } catch (e) {
      debugPrint('Facebook login error: $e');
    }
  }

  Future<void> _loginToBackend(BuildContext context, String fbAccessToken) async {
    try {
      final response = await _dio.post(
        'https://wellness-production.up.railway.app/facebook/login',
        data: {'accessToken': fbAccessToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final jwt = data['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', jwt);

        Navigator.pushReplacementNamed(context, 'MainPage', arguments: jwt);
        debugPrint('✅ JWT Token stored: $jwt');
      } else {
        debugPrint('❌ Backend login failed: ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('❌ Dio error: $e');
    }
  }
}
