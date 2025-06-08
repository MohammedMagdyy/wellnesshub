import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wellnesshub/core/helper_class/accesstoken_storage.dart';
import 'package:wellnesshub/core/utils/global_var.dart';

class DioInterceptorHandlingError {
  final dio = Dio();

  void setupDio() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            // Clear tokens on 401 error
            await LocalStorageAccessToken.removeToken();

            // Add a frame callback to ensure the context is available
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Ensure we have a valid context and navigator key
              if (navigatorKey.currentContext != null) {
                showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (_) => AlertDialog(
                    title: const Text('Session Expired'),
                    content: const Text('Please log in again to continue.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            navigatorKey.currentContext!,
                            'LoginPage',  // Replace with the actual route name
                                (route) => false,
                          );
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            });
          }

          // Allow the error to propagate
          return handler.next(error);
        },
      ),
    );
  }
}
