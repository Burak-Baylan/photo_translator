import 'package:flutter/material.dart';

Future<void> showBasicAlertDialog(
  BuildContext context, {
  Function? onPositiveButtonPressed,
  String? title,
  String? positiveButtonText,
  String? negativeButtonText,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title ?? 'Are you sure to delete?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(negativeButtonText ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onPositiveButtonPressed == null) return;
              onPositiveButtonPressed();
            },
            child: Text(positiveButtonText ?? 'Delete'),
          ),
        ],
      );
    },
  );
}
