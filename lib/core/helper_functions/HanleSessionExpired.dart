import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper_class/accesstoken_storage.dart';
import '../utils/global_var.dart';

Future<void> handleSessionExpired() async {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  // Show a blocking AlertDialog before navigation
  await showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Session Expired'),
        content: const Text('Your session has expired. Please log in again.'),
        actions: [
          TextButton(
            onPressed: () {
              LocalStorageAccessToken.removeToken();
              Navigator.of(dialogContext).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );

  // Remove token from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');

  // Navigate to login screen and clear all previous routes
  navigatorKey.currentState?.pushNamedAndRemoveUntil('LoginPage', (route) => false);

  // Optionally show a SnackBar after redirection
  Future.delayed(const Duration(milliseconds: 200), () {
    final snackBarContext = navigatorKey.currentContext;
    if (snackBarContext != null) {
      ScaffoldMessenger.of(snackBarContext).showSnackBar(
        const SnackBar(
          content: Text('Your session expired. Please login again.'),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  });
}
