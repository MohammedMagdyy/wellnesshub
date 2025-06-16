import 'package:dio/dio.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../models/fitness_plan/planexercises_model.dart';
import 'dart:io';
import 'dart:async';

class WorkoutPlanService {
  Future<ExercisePlan> fetchUserPlan() async {
    dynamic token = await LocalStorageAccessToken.getToken();
    try {
      final response = await API().get(
        url: 'https://wellness-production.up.railway.app/workoutPlan/getUserPlan',
        token: token,
      ).timeout(const Duration(seconds: 10)); // Add timeout

      return ExercisePlan.fromJson(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Could not connect to server. Please try again later.');
      } else if (e.response?.statusCode == 500) {
        throw NetworkException('Our servers are having issues. Please try again later.');
      } else {
        throw NetworkException('Failed to load workout plan: ${e.message}');
      }
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network settings.');
    } on TimeoutException {
      throw NetworkException('Request timed out. Please try again.');
    } catch (e) {
      throw NetworkException('An unexpected error occurred: ${e.toString()}');
    }
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}
