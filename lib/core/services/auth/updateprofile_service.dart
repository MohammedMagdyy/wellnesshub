import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_functions/HanleSessionExpired.dart';
import '../../helper_class/network_exception_class.dart';
import '../../models/update_model.dart';
import 'dart:async';

class UpdateProfileService {
  Future<Map<String, dynamic>> updateProfile(UpdateData updateData) async {
    final token = await LocalStorageAccessToken.getToken();

    final response = await API().post(
      url: 'http://10.0.2.2:8080/updateAccount',
      token: token,
      data: {
        'firstName': updateData.fName,
        'lastName': updateData.lName,
        'email': updateData.email,
        'age': updateData.age,
        'weight': updateData.weight,
        'height': updateData.height,
      },
    );

    // 🛡️ Detect fallback HTML login page
    if (response is String && response.contains('<html')) {
      await handleSessionExpired();
      throw NetworkException('Session expired. Please login again.');
    }

    // ✅ Expected JSON response
    if (response is Map && response['message'] != null) {
      return {
        'success': true,
        'message': response['message'],
      };
    } else {
      return {
        'success': false,
        'message': response is Map
            ? response['message'] ?? 'Update failed'
            : 'Invalid server response',
      };
    }
  }
}
