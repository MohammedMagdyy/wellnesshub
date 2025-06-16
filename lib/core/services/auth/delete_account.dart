import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';

class DeleteAccountService {
  Future<Map<String, dynamic>> deleteAccount() async {
    try {
        dynamic token = await LocalStorageAccessToken.getToken();

      final response = await API().delete(
        url: 'https://wellness-production.up.railway.app/deleteAccount',
        token: token,
      );

      if (response != null && response.toString() == "Account has been deleted") {
        return {'success': true, 'message': 'Account deleted successfully'};
      }

      return {'success': false, 'message': 'Could not delete account'};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data ?? 'Error deleting account'
      };
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error occurred'};
    }
  }
}
