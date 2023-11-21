// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';
import 'package:photo_translator/main.dart';
import '../constants/app_colors.dart';

class SettingsViewPremiumCard extends StatelessWidget {
  SettingsViewPremiumCard({super.key});

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Observer(builder: (context) {
      return globalVm.isPremium
          ? Container()
          : Container(
              decoration: BoxDecoration(
                gradient: AppColors.paywallCardGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              width: context.width,
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: context.height * 0.01,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => globalVm.showPaywall(context),
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -100,
                        bottom: -25,
                        top: -25,
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/crown_image.svg',
                          width: context.width * 0.5,
                          height: context.width * 0.5,
                          color: Colors.white.withOpacity(.2),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: (context.height * .015) + 20,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: informationWidget()),
                                SizedBox(width: context.width * 0.06),
                                buildGetButton(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  Widget informationWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Unlock ',
                style: GoogleFonts.sourceSansPro(
                  color: Colors.white,
                  fontSize: context.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Premium',
                style: GoogleFonts.sourceSansPro(
                  color: Colors.white,
                  fontSize: context.width * 0.04,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height * 0.007),
        Text(
          'Unlock exclusive photo translation capabilities with Premium.',
          style: GoogleFonts.sourceSansPro(
            color: Colors.white,
            fontSize: context.width * 0.03,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget buildGetButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => globalVm.showPaywall(context),
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * .08,
              vertical: context.height * .009,
            ),
            child: Text(
              'Get',
              style: GoogleFonts.sourceSansPro(
                color: AppColors.paywalBackgroundColor2,
                fontSize: context.width * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
