import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackBarContentType {
  static ContentType get success => ContentType.success;
  static ContentType get warning => ContentType.warning;
  static ContentType get help => ContentType.help;
  static ContentType get failure => ContentType.failure;
}

class CustomSnackBar {
  static void show(BuildContext context, String title, String message,
      Color color, ContentType contentType) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        color: color,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
