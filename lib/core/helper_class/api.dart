import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../helper_class/network_exception_class.dart';
import '../helper_functions/HanleSessionExpired.dart';

class API {
  static final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
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
      final errorData = e.response?.data;

      if (errorData is Map && errorData['error'] == 'TokenExpired') {
        await handleSessionExpired();
        throw NetworkException('Authentication failed. Please login again.');
      }

      // Map known errors to messages
      if (e.response?.statusCode == 401) {
        await handleSessionExpired();
        throw NetworkException('Authentication failed. Please login again.');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Could not connect to the server. Try again later.');
      } else if (e.response?.statusCode == 500) {
        throw NetworkException('Server error. Please try again later.');
      } else {
        throw NetworkException('Request failed: ${e.message}');
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
      options: Options(headers: _buildHeaders(token)),
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
      options: Options(headers: _buildHeaders(token)),
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
      options: Options(headers: _buildHeaders(token)),
    ));
  }

  Future<dynamic> delete({
    required String url,
    String? token,
  }) async {
    return _handleRequest(() => dio.delete(
      url,
      options: Options(headers: _buildHeaders(token)),
    ));
  }

  Map<String, String> _buildHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}



// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
//
// class API {
//   static final Dio dio = Dio();
//
//   Future<dynamic> get({
//     required String url,
//     @required String? token,
//     @required dynamic data,
//     }) async {
//     final headers = <String, dynamic>{};
//     if (token != null) {
//       headers['Authorization'] = 'Bearer $token';
//     }
//
//     try {
//       final response = await dio.get(url, options: Options(headers: headers),data: data);
//       return response.data;
//     } on DioException catch (e) {
//       throw e;
//     }
//   }
//
//   Future<dynamic> post({
//     required String url,
//     @required String? token,
//     @required dynamic data,
//   }) async {
//     final headers = <String, dynamic>{
//       'Content-Type': 'application/json',
//     };
//     if (token != null) {
//       headers['Authorization'] = 'Bearer $token';
//     }
//
//     try {
//       final response = await dio.post(
//         url,
//         data: data,
//         options: Options(headers: headers),
//       );
//       return response.data;
//     } on DioException catch (e) {
//       throw e;
//     }
//   }
//
//   Future<dynamic> update({
//     required String url,
//     @required String? token,
//     @required dynamic data,
//   }) async {
//     final headers = <String, dynamic>{
//       'Content-Type': 'application/json',
//     };
//     if (token != null) {
//       headers['Authorization'] = 'Bearer $token';
//     }
//
//     try {
//       final response = await dio.put(
//         url,
//         data: data,
//         options: Options(headers: headers),
//       );
//       return response.data;
//     } on DioException catch (e) {
//       throw e;
//     }
//   }
//
//   Future<dynamic> delete({
//     required String url,
//     @required String? token,
//   }) async {
//     final headers = <String, dynamic>{
//       'Content-Type': 'application/json',
//     };
//     if (token != null) {
//       headers['Authorization'] = 'Bearer $token';
//     }
//
//     try {
//       final response = await dio.delete(
//         url,
//         options: Options(headers: headers),
//       );
//       return response.data;
//     } on DioException catch (e) {
//       throw e;
//     }
//   }
//
// }
