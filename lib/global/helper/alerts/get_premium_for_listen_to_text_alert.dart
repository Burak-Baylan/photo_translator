import 'package:flutter/material.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';
import 'package:photo_translator/main.dart';

Future<void> getPremiumForListenToTextAlertDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xff343034),
      title: const Text(
        'Get Premium',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'You need to get premium to listen to text.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.closeAlertDialog;
            globalVm.showPaywall(context);
          },
          child: const Text(
            'Get Premium',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
