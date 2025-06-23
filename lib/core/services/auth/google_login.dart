import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:wellnesshub/core/utils/global_var.dart';

import '../../helper_class/accesstoken_storage.dart';

class GoogleLoginService {
  final Dio _dio = Dio();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    serverClientId: '815763135583-f1udmtgqbrd86f64kmval97nu57icoss.apps.googleusercontent.com',
  );

  Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        debugPrint('Google sign-in cancelled by user.');
        return {'success': false, 'message': 'Google sign-in cancelled by user'};
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken != null) {
        final backendResult = await _loginToBackend(idToken);
        return backendResult;
      } else {
        debugPrint('Failed to get Google ID token.');
        return {'success': false, 'message': 'Google ID token is null'};
      }
    } catch (e) {
      debugPrint('Google login error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> _loginToBackend(String idToken) async {
    try {
      final response = await _dio.post(
        '$apiUrl/google/login',
        data: {'accessToken': idToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final jwt = response.data['accessToken'];
        print("🔍 Backend response: ${response.data}");


        if (jwt == null) {
          //Save Email  response.data['email']
          String email=response.data['email'];
          print(email);
          await storage.saveUserEmail(email: email);
          return {'success': true, 'message': 'Continue user Info'};
        }

        await LocalStorageAccessToken.saveToken(jwt);
        debugPrint('✅ JWT Token stored from Google: $jwt');

        return {'success': true, 'message': 'Login Success'};
      } else {
        debugPrint('❌ Google backend login failed: ${response.statusMessage}');
        return {'success': false, 'message': response.statusMessage ?? 'Unknown error'};
      }
    } catch (e) {
      debugPrint('❌ Dio error during Google login: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
