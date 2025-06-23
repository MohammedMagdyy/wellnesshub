import 'package:wellnesshub/core/models/fitness_plan/exercises_model.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_class/network_exception_class.dart';
import '../../utils/global_var.dart';

class SpecificExerciseService {
  Future<List<Exercise>> fetchExercises(String regionMuscle) async {
    try {
      final token = await LocalStorageAccessToken.getToken();
      print('Fetching exercises for $regionMuscle');

      final data = await API().get(
        url: '$apiUrl/home/muscleExercises',
        token: token,
        data: {'regionMuscle': regionMuscle},
      );

      // Debug
      print('API response type: ${data.runtimeType}');
      print('API response content: $data');

      // Parse valid response
      if (data is List) {
        return data.map((e) => Exercise.fromJson(e)).toList();
      } else if (data is Map<String, dynamic>) {
        return [Exercise.fromJson(data)];
      } else {
        throw FormatException('Unexpected response format: $data');
      }

    } on FormatException catch (e) {
      throw NetworkException('Data format error: ${e.message}');
    } catch (e, stackTrace) {
      print('Unexpected error: $e\n$stackTrace');
      throw NetworkException('An unexpected error occurred: ${e.toString()}');
    }
  }
}





