import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class API {
  static Dio dio = Dio();

  Future<dynamic> get({required String url, @required String? token}) async {
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception("Failed to find Data :${e.response?.statusCode}");
      } else {
        throw Exception("Failed to find Data :${e.message}");
      }
    }
  }

  Future<dynamic> post({
    required String url,
    @required String? token,
    @required dynamic data,
  }) async {
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response =
          await dio.post(url, options: Options(headers: headers), data: data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception("Failed to Post Data :${e.response?.statusCode}");
      } else {
        throw Exception("Failed to Post Data :${e.message}");
      }
    }
  }

  Future<dynamic> update({
    required String url,
    @required String? token,
    @required dynamic data,
  }) async {
    Map<String, dynamic> headers = {};
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response =
          await dio.put(url, options: Options(headers: headers), data: data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception("Failed to Post Data :${e.response?.statusCode}");
      } else {
        throw Exception("Failed to Post Data :${e.message}");
      }
    }
  }
}
