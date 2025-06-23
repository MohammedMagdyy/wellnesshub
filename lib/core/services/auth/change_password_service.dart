import 'package:dio/dio.dart';
import '../../helper_class/api.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/network_exception_class.dart';
import '../../helper_functions/HanleSessionExpired.dart';
import '../../utils/global_var.dart';

class ChangePasswordService {
  Future<Map<String, dynamic>> changePasswordForRestoreAccount(String email, String password) async {
    final response = await API().post(
      url: '$apiUrl/changePassword?password=$password&email=$email',
      data: null,
      token: null,
    );

    final data = response;

    if (data is Map && data['status'] == "success") {
      return {
        'success': true,
        'message': data['message'] ?? 'Password changed successfully!'
      };
    }

    return {
      'success': false,
      'message': data is Map ? data['message'] ?? 'Something went wrong!' : 'Unexpected response type'
    };

  }

  Future<Map<String, dynamic>> changePassword(String oldPassword, String newPassword) async {
    final token = await LocalStorageAccessToken.getToken();

    final response = await API().post(
      url: '$apiUrl/changePasswordInternal?curPassword=$oldPassword&newPassword=$newPassword',
      data: null,
      token: token,
    );

    final data = response;

    if (data is Map && data['status'] == "success") {
      return {
        'success': true,
        'message': data['message'] ?? 'Password changed successfully!'
      };
    }

    return {
      'success': false,
      'message': data is Map ? data['message'] ?? 'Something went wrong!' : 'Unexpected response type'
    };

  }
}
