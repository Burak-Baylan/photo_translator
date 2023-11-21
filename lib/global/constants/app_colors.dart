import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBackground = Color(0xff171316);
  static const Color lightBackground = Color(0xff302B33);
  static const Color lightBackground2 = Color.fromARGB(255, 65, 65, 74);

  static const Color paywalBackgroundColor1 = Color(0xff657AC7);
  static const Color paywalBackgroundColor2 = Color.fromARGB(255, 64, 79, 137);

  static const Color teal = Color(0xff1B9C85);

  static const LinearGradient paywallBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      paywalBackgroundColor1,
      paywalBackgroundColor2,
      paywalBackgroundColor2,
    ],
  );

  static const LinearGradient paywallCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      paywalBackgroundColor1,
      paywalBackgroundColor2,
    ],
  );
}
