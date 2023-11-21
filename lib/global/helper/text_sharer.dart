import 'package:share_plus/share_plus.dart';

Future<void> share(String text) async {
  try {
    await Share.share(
      text,
      subject: 'Share Text',
    );
  } catch (e) {
    print(e);
  }
}
