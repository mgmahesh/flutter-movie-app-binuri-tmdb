import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context,
    {required String title,
    required String content,
    required String buttonText}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}
