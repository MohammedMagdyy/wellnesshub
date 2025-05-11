import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';

class OTP {
  Future<Map<String, dynamic>> activeOtp({required String email, required String username}) async {
    try {
      final response = await API().post(
        url: 'http://10.0.2.2:8080/active?email=$email&username=$username',
        token: null,
        data: null,
      );

      if (response != null) {
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

  Future<Map<String, dynamic>> verifyOtp({required String email, required String code}) async {
    try {
      final response = await API().post(
        url: 'http://10.0.2.2:8080/verify?email=$email&code=$code',
        token: null,
        data: null,
      );

      if (response != null) {
        final decoded = response.toString();
        if (decoded == 'Account activated successfully!') {
          return {
            "success": true,
            "message": decoded,
          };
        } else if (decoded == 'Invalid activation code.') {
          return {
            "success": false,
            "message": decoded,
          };
        } else {
          return {
            "success": false,
            "message": "Unexpected response from server",
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
