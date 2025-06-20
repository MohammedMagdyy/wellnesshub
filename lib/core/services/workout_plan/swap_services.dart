import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_class/network_exception_class.dart';
import '../../models/fitness_plan/exercises_model.dart';

class SwapService {
  static Future<List<Exercise>> swapExercise(int exerciseId) async {
    final token = await LocalStorageAccessToken.getToken();

    final response = await API().get(
      url: 'https://wellness-production.up.railway.app/exercise/swap?exerciseID=$exerciseId',
      token: token,
    );

    final data = response.data;

    if (data is List) {
      return data.map((e) => Exercise.fromJson(e)).toList();
    } else if (data is Map<String, dynamic>) {
      return [Exercise.fromJson(data)];
    } else {
      throw FormatException('Unexpected response format: $data');
    }
  }

  static Future<Map<String, dynamic>> setSwap(
      int dayID,
      int weekID,
      int oldExerciseID,
      int newExerciseID,
      ) async {
    final token = await LocalStorageAccessToken.getToken();

    final response = await API().post(
      url: 'https://wellness-production.up.railway.app/exercise/setSwap',
      token: token,
      data: {
        "dayID": dayID,
        "weekID": weekID,
        "oldExerciseID": oldExerciseID,
        "newExerciseID": newExerciseID,
      },
    );

    final data = response.data;

    if (data is Map<String, dynamic> && data['message'] != null) {
      return {
        'success': true,
        'message': data['message'],
      };
    }

    return {
      'success': false,
      'message': data?['message'] ?? 'Swap failed',
    };
  }
}
