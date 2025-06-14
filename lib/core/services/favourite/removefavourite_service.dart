import 'package:dio/dio.dart';
import 'package:wellnesshub/core/models/fitness_plan/exercises_model.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import 'dart:io';
import 'dart:async';

import '../../helper_class/network_exception_class.dart';

class RemoveFromFavouriteService {
  Future<Map<String,String>>removeFromFav(int exerciseId) async {
    try {
      final token = await LocalStorageAccessToken.getToken();
      final response = await API().get(
        url: 'http://10.0.2.2:8080/exercise/removeFromFavourite?exerciseID=$exerciseId',
        token: token,
      ).timeout(const Duration(seconds: 10));

      // Handle both array and single object responses
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
    } on DioException catch (e) {
      print('DioError: ${e.response?.data}'); // Debug
      if (e.response?.statusCode == 401) {
        throw NetworkException('Authentication failed. Please login again.');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Could not connect to server. Please try again later.');
      } else if (e.response?.statusCode == 500) {
        throw NetworkException('Our servers are having issues. Please try again later.');
      } else {
        throw NetworkException('Failed to load exercises: ${e.message}');
      }
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network settings.');
    } on TimeoutException {
      throw NetworkException('Request timed out. Please try again.');
    } on FormatException catch (e) {
      throw NetworkException('Data format error: ${e.message}');
    } catch (e, stackTrace) {
      print('Unexpected error: $e\n$stackTrace'); // Debug
      throw NetworkException('An unexpected error occurred: ${e.toString()}');
    }
  }
}

