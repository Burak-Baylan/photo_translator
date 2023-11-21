import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


Future<String> textPaster() async {
  ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
  String? copiedtext = cdata?.text;
  return copiedtext ?? '';
}

void copyText(String text) {
  Clipboard.setData(ClipboardData(text: text));
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: "Copied to clipboard",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
