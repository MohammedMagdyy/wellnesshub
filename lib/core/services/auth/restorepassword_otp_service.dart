import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';

class RestorePasswordService {
  Future<Map<String, dynamic>> restorePassword(String email) async {
    try {
      final response = await API().post(
        url: 'https://wellness-production.up.railway.app/changePasswordRequest?email=$email',
        token: null,
        data: null,  // Assuming data should be null for this POST request, adjust if needed
      );

      if (response != null) {
        // Assuming the response is a JSON object
        final decoded = response is Map<String, dynamic> ? response : jsonDecode(response.toString());

        if (decoded is Map<String, dynamic> && decoded.containsKey('otp')) {
          final otp = decoded['otp']; // Adjust key if needed
          return {
            "success": true,
            "otp": otp,
          };
        } else {
          return {
            "success": false,
            "message": "Unexpected response format from server",
          };
        }
      } else {
        return {
          "success": false,
          "message": "No response from server",
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
        } catch (_) {
          // data was not JSON, do nothing
        }
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

