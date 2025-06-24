import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_class/network_exception_class.dart';
import '../../models/fitness_plan/user_progress_model.dart';
import '../../utils/global_var.dart';

class UserProgressService {
  Future<List<GetUserProgress>> getUserProgress() async {
    try {
      final token = await LocalStorageAccessToken.getToken();

      final data = await API().get(
        url: '$apiUrl/progress/daily',
        token: token,
      );

      print('✅ API response received: ${data.runtimeType}');

      if (data is List) {
        return data
            .map((e) => GetUserProgress.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (data is Map<String, dynamic>) {
        return [GetUserProgress.fromJson(data)];
      } else {
        throw NetworkException('Unexpected response format: $data');
      }
    } catch (e) {
      print('❌ Error in getUserProgress: $e');
      throw NetworkException('Failed to fetch user progress: $e');
    }
  }
}
