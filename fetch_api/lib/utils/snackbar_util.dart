import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message,
    {Color? backgroundColor}) {
  // Show an alert dialog instead of a snackbar
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Notification'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
