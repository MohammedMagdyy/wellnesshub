import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';


import '../../helper_class/accesstoken_storage.dart'; // 👈 update with actual path

class GoogleLoginService {
  final Dio _dio = Dio();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '8815763135583-f1udmtgqbrd86f64kmval97nu57icoss.apps.googleusercontent.com',
    //815763135583-f1udmtgqbrd86f64kmval97nu57icoss.apps.googleusercontent.com
  );

  Future<bool> loginWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        debugPrint('Google sign-in cancelled by user.');
        return false;
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken != null) {
        return await _loginToBackend(idToken);
      } else {
        debugPrint('Failed to get Google ID token.');
        return false;
      }
    } catch (e) {
      debugPrint('Google login error: $e');
      return false;
    }
  }

  Future<bool> _loginToBackend(String idToken) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8080/google/login',
        data: {'accessToken': idToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final jwt = response.data['accessToken'];

        // ✅ Save token using your helper
        await LocalStorageAccessToken.saveToken(jwt);

        debugPrint('✅ JWT Token stored from Google: $jwt');
        return true;
      } else {
        debugPrint('❌ Google backend login failed: ${response.statusMessage}');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Dio error during Google login: $e');
      return false;
    }
  }
}
