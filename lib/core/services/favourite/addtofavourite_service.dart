import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_functions/HanleSessionExpired.dart';
import '../../helper_class/network_exception_class.dart';

class AddToFavouriteService {
  Future<Map<String, String>> addToFav(int exerciseId) async {
    final token = await LocalStorageAccessToken.getToken();

    final response = await API().get(
      url: 'https://wellness-production.up.railway.app/exercise/addToFavourite?exerciseID=$exerciseId',
      token: token,
    );

    // 🛡️ Handle OAuth fallback
    if (response.data is String && response.data.toString().contains('<html')) {
      await handleSessionExpired();
      throw NetworkException('Session expired. Please login again.');
    }

    // ✅ Parse valid JSON response
    final data = response.data;
    if (data is Map<String, dynamic>) {
      final status = data['status'];
      final message = data['message'];

      if (status is String && message is String) {
        return {'status': status, 'message': message};
      } else {
        throw FormatException('Invalid status or message format.');
      }
    } else {
      throw FormatException('Unexpected response format: $data');
    }
  }
}
