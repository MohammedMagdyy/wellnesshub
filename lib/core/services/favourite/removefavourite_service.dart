import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_functions/HanleSessionExpired.dart';
import '../../helper_class/network_exception_class.dart';
import 'dart:io';
import 'dart:async';

class RemoveFromFavouriteService {
  Future<Map<String, String>> removeFromFav(int exerciseId) async {
    final token = await LocalStorageAccessToken.getToken();
    final response = await API().get(
      url: 'https://wellness-production.up.railway.app/exercise/removeFromFavourite?exerciseID=$exerciseId',
      token: token,
    );

    // 🛡️ Central fallback: OAuth HTML response
    if (response is String && response.contains('<html')) {
      await handleSessionExpired();
      throw NetworkException('Session expired. Please login again.');
    }

    // ✅ Success: Check for valid response
    if (response is Map<String, dynamic>) {
      final status = response['status'];
      final message = response['message'];

      if (status is String && message is String) {
        return {
          'status': status,
          'message': message,
        };
      } else {
        throw FormatException('Invalid status or message format.');
      }
    } else {
      throw FormatException('Unexpected response format: $response');
    }
  }
}
