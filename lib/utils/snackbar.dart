import 'package:flutter/material.dart';

void showSomeFeedback(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
    ),
  );
}
