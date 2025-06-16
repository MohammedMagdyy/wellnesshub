import 'package:dio/dio.dart';
import '../../helper_class/api.dart';

class ChangePasswordService {
  Future<Map<String, dynamic>> changePasswordForRestoreAccount(String email, String password) async {
    try {
      final response = await API().post(
        url: 'https://wellness-production.up.railway.app/changePassword?password=$password&email=$email',
        data: null,
        token: null,
      );

      if (response != null && response['status'] == "success") {
        return {
          'success': true,
          'message': response['message'] ?? 'Password changed successfully!'
        };
      }

      return {
        'success': false,
        'message': 'Something went wrong!'
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Error changing password'
      };
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error!'};
    }
  }

  Future<Map<String, dynamic>> changePassword(String oldPassword, String newPassword) async {
    try {
      final response = await API().post(
        url: 'http://10.0.2.2:8080/changePasswordInternal?curPassword=$oldPassword&newPassword=$newPassword',
        data: null,
        token: null,
      );

      if (response != null && response['status'] == "success") {
        return {
          'success': true,
          'message': response['message'] ?? 'Password changed successfully!'
        };
      }

      return {
        'success': false,
        'message': 'Something went wrong!'
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Error changing password'
      };
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error!'};
    }
  }
}
