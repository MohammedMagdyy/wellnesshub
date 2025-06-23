import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../models/fitness_plan/exercises_model.dart';
import '../../helper_class/network_exception_class.dart';
import '../../utils/global_var.dart';

class ShowFavouriteService {
  Future<List<Exercise>> showFavourites() async {
    final token = await LocalStorageAccessToken.getToken();

    final data = await API().get(
      url: '$apiUrl/favourite/getFavouriteExercises',
      token: token,
    );

    print('API response received: ${data.runtimeType}');

    if (data is List) {
      return data.map((e) => Exercise.fromJson(e)).toList();
    } else if (data is Map<String, dynamic>) {
      return [Exercise.fromJson(data)];
    } else {
      throw NetworkException('Unexpected response format: $data');
    }
  }
}

