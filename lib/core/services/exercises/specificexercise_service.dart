import 'package:dio/dio.dart';
import 'package:wellnesshub/core/models/fitness_plan/exercises_model.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_class/network_exception_class.dart';

class SpecificExerciseService {
  Future<List<Exercise>> fetchExercises(String regionMuscle) async {
    try {
      final token = await LocalStorageAccessToken.getToken();
      print('Fetching exercises for $regionMuscle');

      final data = await API().get(
        url: 'http://10.0.2.2:8080/home/muscleExercises',
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



// class SpecificExerciseService {
//   Future<List<Exercise>> fetchExercises(String regionMuscle) async {
//     try {
//       final token = await LocalStorageAccessToken.getToken();
//       print('Fetching exercises for $regionMuscle with token: ${token?.substring(0, 5)}...'); // Debug
//
//       final response = await API().get(
//         url: 'http://10.0.2.2:8080/home/muscleExercises?regionMuscle=$regionMuscle',
//         //https://wellness-production.up.railway.app
//         token: token,
//       ).timeout(const Duration(seconds: 10));
//       if (response.statusCode == 401&&response.data.toString().contains("TokenExpired")) {
//         await handleSessionExpired();
//         throw NetworkException('Session expired. Please login again.');
//       }
//
//       print('API response received: ${response.runtimeType}'); // Debug
//
//       // Handle both array and single object responses
//       if (response is List) {
//         return response.map((e) => Exercise.fromJson(e)).toList();
//       } else if (response is Map<String, dynamic>) {
//         return [Exercise.fromJson(response)];
//       } else {
//         throw FormatException('Unexpected response format: $response');
//       }
//     } on DioException catch (e) {
//       if (e.response?.data['error'] == 'TokenExpired') {
//         await handleSessionExpired();
//         return Future.error('Authentication failed. Please login again.');
//       }
//       print('DioError: ${e.response?.data}'); // Debug
//       if (e.response?.statusCode == 401) {
//         throw NetworkException('Authentication failed. Please login again.');
//       } else if (e.type == DioExceptionType.connectionTimeout) {
//         throw NetworkException('Connection timeout. Please check your internet connection.');
//       } else if (e.type == DioExceptionType.connectionError) {
//         throw NetworkException('Could not connect to server. Please try again later.');
//       } else if (e.response?.statusCode == 500) {
//         throw NetworkException('Our servers are having issues. Please try again later.');
//       } else {
//         throw NetworkException('Failed to load exercises: ${e.message}');
//       }
//     } on SocketException {
//       throw NetworkException('No internet connection. Please check your network settings.');
//     } on TimeoutException {
//       throw NetworkException('Request timed out. Please try again.');
//     } on FormatException catch (e) {
//       throw NetworkException('Data format error: ${e.message}');
//     } catch (e, stackTrace) {
//       print('Unexpected error: $e\n$stackTrace'); // Debug
//       throw NetworkException('An unexpected error occurred: ${e.toString()}');
//     }
//   }
// }

