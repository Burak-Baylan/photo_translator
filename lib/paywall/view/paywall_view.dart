// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';

import '../../global/constants/app_colors.dart';
import '../../global/helper/purchase_helper.dart';
import '../view_model/paywall_view_model.dart';

class PaywallView extends StatefulWidget {
  const PaywallView({super.key});

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  late BuildContext context;

  PaywallViewModel paywallVm = PaywallViewModel();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    paywallVm.init(context);
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
          gradient: AppColors.paywallBackgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: context.width * .05),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: context.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildCloseButton(),
                              buildPageTitle,
                              buildCloseButton(isClosed: true),
                            ],
                          ),
                          SizedBox(height: context.height * 0.01),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  buildFeaturesList(),
                                  SizedBox(height: context.height * 0.03),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: buildOfferButton(
                                  //         PackageEnum.weekly,
                                  //         price: PurchaseHelper
                                  //             .shared.getWeeklyPriceStr,
                                  //         topText: 'Weekly',
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 10),
                                  //     Expanded(
                                  //       child: buildOfferButton(
                                  //         PackageEnum.monthly,
                                  //         price: PurchaseHelper
                                  //             .shared.get3MonthsPriceStr,
                                  //         topText:
                                  //             '3 Months + 3-day free trial',
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  buildOfferButton(
                                    PackageEnum.weekly,
                                    price:
                                        PurchaseHelper.shared.getWeeklyPriceStr,
                                    topText: 'Weekly',
                                  ),
                                  const SizedBox(height: 10),
                                  buildOfferButton(
                                    PackageEnum.monthly,
                                    openSaveCard: true,
                                    isSaveCardYearly: false,
                                    price: PurchaseHelper
                                        .shared.get3MonthsPriceStr,
                                    topText: '3 Months + 3-day free trial',
                                    bottomDesc:
                                        '3 days free, then ${PurchaseHelper.shared.get3MonthsPriceAsWeeklyStr} -',
                                  ),
                                  const SizedBox(height: 10),
                                  buildOfferButton(
                                    PackageEnum.yearly,
                                    openSaveCard: true,
                                    price:
                                        PurchaseHelper.shared.getYearlyPriceStr,
                                    topText: '12 Months + 3-day free trial',
                                    bottomDesc:
                                        '3 days free, then ${PurchaseHelper.shared.getYearlyPriceAsWeeklyStr} -',
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 5),
                        buildBuyButton(),
                        CupertinoButton(
                          onPressed: () => paywallVm.restore(),
                          padding: EdgeInsets.zero,
                          child: Text(
                            'Restore',
                            style: TextStyle(
                              color: Colors.grey[350],
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              loadingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return Observer(builder: (_) {
      if (paywallVm.isLoading) {
        return Container(
          width: context.width,
          height: context.height,
          color: Colors.black.withOpacity(.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  //? diğer yearly buton
  // buildOfferButton(
  //   PackageEnum.yearly,
  //   openSaveCard: true,
  //   price: '${PurchaseHelper.shared.getYearlyPriceAsWeeklyStr} *',
  //   topText: 'Annual + 3-day free trial',
  //   bottomDesc: '* 3 day free then ${PurchaseHelper.shared.getYearlyPriceStr} -',
  // );

  Widget buildOfferButton(
    PackageEnum packageEnum, {
    required String price,
    required String topText,
    bool openSaveCard = false,
    bool isSaveCardYearly = true,
    String? bottomDesc,
    double? height,
  }) {
    return Observer(builder: (_) {
      bool isSelected = packageEnum == paywallVm.selectedPackage;
      return Container(
        width: context.width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          color: isSelected
              ? const Color(0xff2B246D)
              : Colors.grey[350]!.withOpacity(.1),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => paywallVm.setSelectedPackage(packageEnum),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              topText,
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: context.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                      openSaveCard
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0xff59AD89),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 5,
                              ),
                              child: Text(
                                'Save ${isSaveCardYearly ? PurchaseHelper.shared.getYearlyDiscountRatio : PurchaseHelper.shared.get3MonthlyDiscountRatio}%',
                                style: const TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    child: Text(
                      price,
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: context.width * 0.05,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${bottomDesc ?? ''} Cancel anytime',
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: bottomDesc != null
                          ? FontWeight.w700
                          : FontWeight.w300,
                      color: Colors.grey[400],
                      fontSize: context.width * 0.03,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildBuyButton() {
    return Observer(builder: (_) {
      return Container(
        width: context.width,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => paywallVm.purchase(),
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              width: context.width,
              height: 52,
              child: Center(
                child: Text(
                  paywallVm.isPackageWeekly
                      ? 'Subscribe now'
                      : 'Try free & subscribe',
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff4B4676),
                    fontSize: context.width * 0.06,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget get buildPageTitle {
    return FittedBox(
      child: Text(
        'Try Premium',
        textAlign: TextAlign.center,
        style: context.theme.textTheme.headline1!.copyWith(
          color: Colors.white,
          fontSize: context.width * 0.08,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildFeaturesList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildFeatureCard(
          "assets/svg/camera_icon.svg",
          bgColor: const Color.fromARGB(255, 211, 208, 114).withOpacity(.6),
          iconColor: const Color.fromARGB(255, 178, 186, 87),
          title: 'Unlimited Camera Translation',
          desc: 'Unlimited translation with camera.',
        ),
        // buildFeatureCard(
        //   "assets/svg/camera_icon.svg",
        //   bgColor: const Color(0xffFB4B58).withOpacity(.6),
        //   iconColor: const Color(0xffFB4B58),
        //   title: 'No Ads',
        //   desc: 'No ads will be shown in the app.',
        // ),
        buildFeatureCard(
          "assets/svg/ai_icon.svg",
          bgColor: const Color.fromARGB(255, 44, 128, 145).withOpacity(.6),
          iconColor: const Color.fromARGB(255, 41, 106, 119),
          title: 'AI Powered Translation',
          desc: 'Unlock AI powered translation.',
        ),
        buildFeatureCard(
          "assets/svg/thunder_icon.svg",
          bgColor: const Color.fromARGB(255, 147, 182, 120).withOpacity(.4),
          iconColor: const Color.fromARGB(255, 131, 185, 90),
          title: '2.4x Faster Translation',
          desc: '2.4x faster translation.',
        ),
        buildFeatureCard(
          "assets/svg/voice_icon.svg",
          bgColor: const Color(0xff804674).withOpacity(.6),
          iconColor: const Color(0xff804674),
          title: 'Listen Translations',
          desc: 'Listen your translated texts.',
        ),
      ],
    );
  }

  Widget buildCloseButton({bool isClosed = false}) {
    return Observer(builder: (context) {
      return Visibility(
        visible: paywallVm.isCloseButtonVisible,
        child: Container(
          margin: EdgeInsets.only(
            left: context.width * .03,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isClosed ? null : () => context.pop,
              borderRadius: BorderRadius.circular(9999),
              child: Icon(
                CupertinoIcons.xmark,
                color: isClosed
                    ? Colors.transparent
                    : Colors.white.withOpacity(.3),
                size: context.width * .045,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildFeatureCard(
    String imagePath, {
    required Color bgColor,
    required Color iconColor,
    required String title,
    required String desc,
    bool isSvg = true,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: bgColor,
              ),
              padding: const EdgeInsets.all(8),
              child: isSvg
                  ? SvgPicture.asset(
                      imagePath,
                      width: context.width * .08,
                      color: iconColor,
                    )
                  : Image.asset(
                      imagePath,
                      width: context.width * .08,
                      height: context.width * .08,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTitleWidget(title, bgColor),
                Text(
                  desc,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: context.width * .04,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitleWidget(String title, Color bgColor) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: context.width * .045,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: bgColor,
              fontWeight: FontWeight.bold,
              fontSize: context.width * .045,
            ),
          ),
        ),
      ],
    );
  }
}
