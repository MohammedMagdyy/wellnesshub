import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_functions/HanleSessionExpired.dart';
import '../../helper_class/network_exception_class.dart';
import 'dart:io';
import 'dart:async';

import '../../utils/global_var.dart';

class DeleteAccountService {
  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final token = await LocalStorageAccessToken.getToken();

      final data = await API().delete(
        url: '$apiUrl/deleteAccount',
        token: token,
      );

      // Detect OAuth/HTML redirect fallback
      if (data is String && data.contains('<html')) {
        await handleSessionExpired();
        throw NetworkException('Session expired. Please login again.');
      }

      // Successful deletion
      if (data is Map && data['message']?.toString().contains("Account has been deleted") == true) {
        //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        LocalStorageAccessToken.removeToken();
        return {'success': true, 'message': data['message']};
      }

      return {'success': false, 'message': data?['message'] ?? 'Could not delete account'};

    } on DioException catch (e) {
      final data = e.response?.data;

      if (e.response?.statusCode == 401 || (data is String && data.contains("TokenExpired")) || (data is Map && data['error'] == 'TokenExpired')) {
        await handleSessionExpired();
        return Future.error('Session expired. Please login again.');
      }

      return {
        'success': false,
        'message': data is Map && data['message'] != null
            ? data['message']
            : 'Error deleting account'
      };

    } on SocketException {
      return {'success': false, 'message': 'No internet connection'};
    } on TimeoutException {
      return {'success': false, 'message': 'Request timed out'};
    } catch (e, stackTrace) {
      print('Unexpected error: $e\n$stackTrace');
      return {'success': false, 'message': 'Unexpected error occurred'};
    }
  }
}

