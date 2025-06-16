import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import '../helper_class/accesstoken_storage.dart';
import '../helper_class/api.dart';
import '../helper_class/network_exception_class.dart';
import '../models/sign_up/full_userinfo_model.dart';

class getUserInfoService {
  Future<FullUserInfo> getUserInfo() async {
    try {
      final token = await LocalStorageAccessToken.getToken();
      final response = await API().get(
        url: 'https://wellness-production.up.railway.app/getUserInfo',
        token: token,
      ).timeout(const Duration(seconds: 10));

      print('API response received: ${response.runtimeType}'); // Debug
      if (response is Map<String, dynamic>) {
        return FullUserInfo.fromJson(response);
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

