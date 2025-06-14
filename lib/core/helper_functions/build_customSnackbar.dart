import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

SnackBar buildCustomSnackbar({
  required String title,
  required String message,
  required ContentType type,
  required Color backgroundColor,
}) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 1),
    
    
    content: AwesomeSnackbarContent(
      color: backgroundColor,
      title: title,
      message: message,
      contentType: type,
    ),
  );
}

