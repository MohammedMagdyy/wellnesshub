import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_class/network_exception_class.dart';
import '../../utils/global_var.dart';

class DoneService {
  Future<Map<String, dynamic>> exerciseDone(int exerciseID, int weekID, int dayID) async {
    try {
      final token = await LocalStorageAccessToken.getToken();

      final data = await API().post(
        url: '$apiUrl/exercise/done',
        token: token,
        data: {
          'exerciseID': exerciseID,
          'weekID': weekID,
          'dayID': dayID,
        },
      );

      // If backend returns a new access token
      if (data != null && data['accessToken'] != null) {
        await LocalStorageAccessToken.saveToken(data['accessToken']);
        return {'success': true, 'message': 'Exercise marked as done'};
      }

      return {
        'success': false,
        'message': data?['message'] ?? 'Unexpected response format'
      };

    } on FormatException catch (e) {
      throw NetworkException('Data format error: ${e.message}');
    } catch (e, stackTrace) {
      print('Unexpected error: $e\n$stackTrace');
      throw NetworkException('An unexpected error occurred: ${e.toString()}');
    }
  }
}

