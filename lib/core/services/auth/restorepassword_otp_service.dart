import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';

import '../../utils/global_var.dart';

class RestorePasswordService {
  Future<Map<String, dynamic>> restorePassword(String email) async {
    try {
      final encodedEmail = Uri.encodeComponent(email);

      final response = await API().post(
        url: '$apiUrl/changePasswordRequest?email=$encodedEmail',
        token: null,
        data: null,
      );

      final decoded = response is Map<String, dynamic> ? response : jsonDecode(response.toString());

      if (decoded is Map<String, dynamic> && decoded.containsKey('otp')) {
        return {
          "success": true,
          "otp": decoded['otp'],
        };
      } else {
        return {
          "success": false,
          "message": "Unexpected response format from server",
        };
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = 'Connection error: ${e.message}';

      if (data is Map<String, dynamic> && data.containsKey('message')) {
        errorMessage = data['message'];
      } else if (data is String) {
        try {
          final parsed = jsonDecode(data);
          if (parsed is Map<String, dynamic> && parsed.containsKey('message')) {
            errorMessage = parsed['message'];
          }
        } catch (_) {}
      }

      return {
        "success": false,
        "message": errorMessage,
      };
    } catch (e) {
      return {
        "success": false,
        "message": 'Unexpected error: $e',
      };
    }
  }
}
