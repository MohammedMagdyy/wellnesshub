import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleLoginService {
  final Dio _dio = Dio();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: 'http://815763135583-l8n3k6e0f8mk0b6nki32umaug4vavpi5.apps.googleusercontent.com',
  );

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        debugPrint('Google sign-in cancelled by user.');
        return;
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken != null) {
        await _loginToBackend(context, idToken);
      } else {
        debugPrint('Failed to get Google ID token.');
      }
    } catch (e) {
      debugPrint('Google login error: $e');
    }
  }

  Future<void> _loginToBackend(BuildContext context, String idToken) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8080/google/login',
        data: {'idToken': idToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final jwt = data['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', jwt);

        Navigator.pushReplacementNamed(context, 'MainPage', arguments: jwt);
        debugPrint('✅ JWT Token stored from Google: $jwt');
      } else {
        debugPrint('❌ Google backend login failed: ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('❌ Dio error during Google login: $e');
    }
  }
}
