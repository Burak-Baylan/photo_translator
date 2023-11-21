// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_translator/main.dart';
import 'package:photo_translator/view/on_boarding_page/view/widget/on_boarding_item_widget.dart';

import '../../../global/constants/app_colors.dart';
import '../view_model/on_boarding_view_model.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({
    super.key,
    this.popAfterDone = false,
    this.dontCheckFirstInit = false,
  });

  bool popAfterDone;
  bool dontCheckFirstInit;

  OnBoardingViewModel viewModel = OnBoardingViewModel();

  List<OnBoardingItem> onBoardingItems = [
    OnBoardingConstants.page1Item,
    OnBoardingConstants.page2Item,
    OnBoardingConstants.page3Item,
  ];

  void init(BuildContext context) {
    viewModel.setContext(context);
    viewModel.init(popAfterDone);
    globalVm.setFirstInit(0);
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: viewModel.pageController,
              children: [
                OnBoardingItemWidget(
                    onBoardingItem: onBoardingItems[0], index: 0),
                OnBoardingItemWidget(
                    onBoardingItem: onBoardingItems[1], index: 1),
                OnBoardingItemWidget(
                    onBoardingItem: onBoardingItems[2], index: 2),
              ],
            ),
          ),
          SizedBox(height: 50),
          buildBottomWidget(),
          SizedBox(height: 50)
        ],
      ),
    );
  }

  Widget buildBottomWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        pageDotsWidget(),
        SizedBox(height: 50),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              skipAndBackButton(),
              SizedBox(width: 10),
              doneAndNextButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget doneAndNextButton() {
    return Expanded(
      child: Observer(builder: (_) {
        return ElevatedButton(
          onPressed: () => viewModel.nextPage(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              viewModel.currentPage == 2 ? 'Done' : 'Next',
              style: GoogleFonts.chakraPetch(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget skipAndBackButton() {
    return Expanded(
      child: Observer(builder: (_) {
        return TextButton(
          onPressed: () => viewModel.previousPage(),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              viewModel.currentPage == 0 ? 'Skip' : 'Back',
              textAlign: TextAlign.center,
              style: GoogleFonts.chakraPetch(
                fontSize: 17,
                color: AppColors.teal,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget pageDotsWidget() {
    return Observer(builder: (_) {
      return viewModel.currentPage == 4
          ? Container()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                pageDotWidget(viewModel.currentPage == 0),
                const SizedBox(width: 4),
                pageDotWidget(viewModel.currentPage == 1),
                const SizedBox(width: 4),
                pageDotWidget(viewModel.currentPage == 2),
              ],
            );
    });
  }

  Widget pageDotWidget(bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
        color: isSelected ? AppColors.teal : Colors.grey.shade400,
      ),
      width: 8,
      height: 8,
    );
  }
}

class OnBoardingItem {
  String lottiePath;
  String title;
  String subtitle;

  OnBoardingItem({
    required this.lottiePath,
    required this.title,
    required this.subtitle,
  });
}

class OnBoardingConstants {
  static OnBoardingItem page1Item = OnBoardingItem(
    lottiePath: OnBoardingConstants._page1LottiePath,
    title: OnBoardingConstants._page1Title,
    subtitle: OnBoardingConstants._page1Subtitle,
  );

  static OnBoardingItem page2Item = OnBoardingItem(
    lottiePath: OnBoardingConstants._page2LottiePath,
    title: OnBoardingConstants._page2Title,
    subtitle: OnBoardingConstants._page2Subtitle,
  );

  static OnBoardingItem page3Item = OnBoardingItem(
    lottiePath: OnBoardingConstants._page3LottiePath,
    title: OnBoardingConstants._page3Title,
    subtitle: OnBoardingConstants._page3Subtitle,
  );

  static const String _page1LottiePath =
      'assets/lotties/take_photo_lottie.json';
  static const String _page1Title = 'Camera Translation';
  static const String _page1Subtitle =
      'Take a photo of anything you want and instantly translate it into the chosen language';

  static const String _page2LottiePath = 'assets/lotties/languages_lottie.json';
  static const String _page2Title = 'More Than 100+';
  static const String _page2Subtitle =
      'Translate instantly and easily into over 100+ languages';

  static const String _page3LottiePath = 'assets/lotties/translate_lottie.json';
  static const String _page3Title = 'Fast Translate';
  static const String _page3Subtitle =
      'Quickly translate while chatting with your friend';
}
