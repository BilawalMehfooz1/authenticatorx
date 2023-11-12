import 'package:flutter/material.dart';

void showSnack({required String content, required BuildContext context}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

void showErrorDialog({required BuildContext context, required String content}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(content),
        title: const Text('Something went wrong!'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
