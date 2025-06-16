import 'package:dio/dio.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import 'dart:io';
import 'dart:async';
import '../../helper_class/network_exception_class.dart';

class DoneService{
  Future<Map<String, dynamic>> exerciseDone(int exerciseID,int weekID,int dayID) async {
    try {
      final token = await LocalStorageAccessToken.getToken();
      final response = await API().get(
        url: 'https://wellness-production.up.railway.app/exercise/done',
        data:{
          "exerciseID":exerciseID,
          "weekID":weekID,
          "dayID":dayID,
        },
        token: token,
      ).timeout(const Duration(seconds: 10));

      print('API response received: ${response.runtimeType}'); // Debug

      //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      // Handle both array and single object responses
      if (response != null && response['accessToken'] != null) {
        await LocalStorageAccessToken.saveToken(response['accessToken']);
        return {'success': true, 'message': 'Login successful'};
      }
      return {
        'success': false,
        'message': response['message'] ?? 'Invalid credentials'
      };

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
        throw NetworkException('Failed to Mark as Done: ${e.message}');
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