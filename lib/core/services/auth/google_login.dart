import 'dart:convert';

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

        if (jwt == null) {
          String email = response.data['email'];
          print(email);
          await storage.saveUserEmail(email: email);
          return {'success': true, 'message': 'Continue user Info'};
        }

        await LocalStorageAccessToken.saveToken(jwt);
        debugPrint('✅ JWT Token stored from Google: $jwt');

        return {'success': true, 'message': 'Login Success'};
      } else {
        return {
          'success': false,
          'message': response.statusMessage ?? 'Unknown error occurred'
        };
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
          message = 'Unauthorized Google login: Invalid or expired token.';
        }
      } catch (err) {
        debugPrint('Error decoding backend error: $err');
        message = 'Failed  error ';
      }

      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint('❌ Unexpected error during Google login: $e');
      return {'success': false, 'message': 'Unexpected error: ${e.toString()}'};
    }
  }


}
