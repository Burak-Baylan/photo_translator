// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(BuildContext context, String link) async {
  await launchUrl(Uri.parse(link));
}
