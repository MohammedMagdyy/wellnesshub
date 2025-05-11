import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class API {
  static final Dio dio = Dio();

  Future<dynamic> get({required String url, @required String? token}) async {
    final headers = <String, dynamic>{};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await dio.get(url, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<dynamic> post({
    required String url,
    @required String? token,
    @required dynamic data,
  }) async {
    final headers = <String, dynamic>{
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<dynamic> update({
    required String url,
    @required String? token,
    @required dynamic data,
  }) async {
    final headers = <String, dynamic>{
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<dynamic> delete({
    required String url,
    @required String? token,
  }) async {
    final headers = <String, dynamic>{
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await dio.delete(
        url,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }

}
