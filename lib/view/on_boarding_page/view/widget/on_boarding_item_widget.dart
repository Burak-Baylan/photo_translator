import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';

import '../../../../global/constants/app_colors.dart';
import '../on_boarding_page.dart';

class OnBoardingItemWidget extends StatelessWidget {
  const OnBoardingItemWidget({
    super.key,
    required this.onBoardingItem,
    required this.index,
  });

  final int index;
  final OnBoardingItem onBoardingItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 50),
        LottieBuilder.asset(
          onBoardingItem.lottiePath,
          width: context.width * 0.7,
        ),
        Expanded(child: buildTexts()),
      ],
    );
  }

  Widget buildTexts() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildText(
              onBoardingItem.title,
              GoogleFonts.chakraPetch(
                color: AppColors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 20),
            buildText(
              onBoardingItem.subtitle,
              GoogleFonts.signika(
                color: Colors.grey.shade400.withOpacity(1),
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text, TextStyle style) {
    return Text(
      text,
      textAlign: index == 4 ? TextAlign.left : TextAlign.center,
      style: style,
    );
  }
}
