// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';
import 'package:photo_translator/main.dart';

Widget textSpanWithOneNormalOneBold() {
  return RichText(
    text: TextSpan(
      children: [
        const TextSpan(
          text: 'You have ',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        TextSpan(
          text: '${globalVm.getRemainingCameraTranslation()}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const TextSpan(
          text:
              ' photo credit left.\nIf you want unlimited translation from the camera, you can subscribe now!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Future<void> showRemainingCreditCountDialog(BuildContext context) async {
  int photoCredit = await globalVm.getRemainingCameraTranslation();
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xff343034),
      title: Text(
        'Remaining Photo Translate Credit: $photoCredit',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'You have $photoCredit',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const TextSpan(
              text:
                  ' photo credit left. \n\nIf you want unlimited translation from the camera, ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const TextSpan(
              text: 'you can get Premium now!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.closeAlertDialog;
            globalVm.showPaywall(context);
          },
          child: const Text(
            'Get',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Future<void> showNoMorePhotoCreditDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'No More Photo Translate Credit',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'If you want unlimited translation from the camera, ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'you can get Premium now!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => globalVm.showPaywall(context),
          child: const Text(
            'Get',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
