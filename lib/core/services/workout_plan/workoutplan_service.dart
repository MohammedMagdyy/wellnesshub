import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../models/fitness_plan/planexercises_model.dart';
import '../../helper_class/network_exception_class.dart';
import '../../helper_functions/HanleSessionExpired.dart';
import '../../utils/global_var.dart';

class WorkoutPlanService {
  Future<ExercisePlan> fetchUserPlan() async {
    final token = await LocalStorageAccessToken.getToken();
    final data = await API().get(
      url: '$apiUrl/workoutPlan/getUserPlan',
      token: token,
    );


    if (data is String && data.contains('<html')) {
      await handleSessionExpired();
      throw NetworkException('Session expired. Please login again.');
    }

    if (data is Map<String, dynamic>) {
      return ExercisePlan.fromJson(data);
    } else {
      throw FormatException('Unexpected response format');
    }

  }
}
