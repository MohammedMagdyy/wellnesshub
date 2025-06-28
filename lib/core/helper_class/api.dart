import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../helper_class/network_exception_class.dart';
import '../helper_functions/HanleSessionExpired.dart';

class API {
  static final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
  ));

  Future<dynamic> _handleRequest(Future<Response> Function() request) async {
    try {
      final response = await request();

      // Case 1: OAuth HTML fallback
      if (response.data is String && response.data.toString().contains('<html')) {
        await handleSessionExpired();
        throw NetworkException('Session expired. Please login again.');
      }

      // Case 2: Expired JWT token or backend 401 + message
      if (response.statusCode == 401 && response.data.toString().contains("TokenExpired")) {
        await handleSessionExpired();
        throw NetworkException('Session expired. Please login again.');
      }

      return response.data; // Always return just the data part
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      dynamic errorData = e.response?.data;

      // Default error message
      String message = 'Request failed: ${e.message}';

      // Attempt to extract meaningful message from response body
      try {
        if (errorData is Map && errorData['message'] != null) {
          message = errorData['message'];
        } else if (errorData is String) {
          final parsed = jsonDecode(errorData);
          if (parsed is Map && parsed['message'] != null) {
            message = parsed['message'];
          }
        }
      } catch (_) {
        // JSON parse error; keep default message
      }

      if (statusCode == 401) {
        await handleSessionExpired();
        throw NetworkException('Authentication failed. Please login again.');
      } else if (statusCode == 500) {
        throw NetworkException('Server error. Please try again later.');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Could not connect to the server. Try again later.');
      } else {
        throw NetworkException(message);
      }
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network.');
    } on TimeoutException {
      throw NetworkException('Request timed out. Please try again.');
    } catch (e, stack) {
      print('Unhandled exception: $e\n$stack');
      throw NetworkException('Unexpected error occurred: ${e.toString()}');
    }
  }


  Future<dynamic> get({
    required String url,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    return _handleRequest(() => dio.get(
      url,
      queryParameters: data,
      options: Options(headers: buildHeaders(token)),
    ));
  }

  Future<dynamic> post({
    required String url,
    String? token,
    dynamic data,
  }) async {
    return _handleRequest(() => dio.post(
      url,
      data: data,
      options: Options(headers: buildHeaders(token)),
    ));
  }

  Future<dynamic> update({
    required String url,
    String? token,
    dynamic data,
  }) async {
    return _handleRequest(() => dio.put(
      url,
      data: data,
      options: Options(headers: buildHeaders(token)),
    ));
  }

  Future<dynamic> delete({
    required String url,
    String? token,
  }) async {
    return _handleRequest(() => dio.delete(
      url,
      options: Options(headers: buildHeaders(token)),
    ));
  }

  Map<String, String> buildHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}

