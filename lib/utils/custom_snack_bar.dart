import 'package:flutter/material.dart';
class CustomSnackBar {
  void showSnackBar(
      {required BuildContext context, required String content, required Color backgroundColor}) {
    final snackBar = SnackBar(
      content: Text(content, style: const TextStyle(fontSize: 18),),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 10,
    );
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()..showSnackBar(snackBar);
  }
}