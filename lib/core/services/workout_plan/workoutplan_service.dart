import 'package:dio/dio.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../models/fitness_plan/planexercises_model.dart';

class WorkoutPlanService {
  Future<ExercisePlan> fetchUserPlan() async {
    dynamic token = await LocalStorageAccessToken.getToken();
    try {
      final data = await API().get(
        url: 'http://10.0.2.2:8080/workoutPlan/getUserPlan',
        token: token,
      );

      return ExercisePlan.fromJson(data); // ✅ data is already Map
    } catch (e) {
      throw Exception('Error fetching workout plan: $e');
    }
  }
}

