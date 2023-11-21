import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_translator/main.dart';
import 'package:photo_translator/view/settings/view/settings_view.dart';
import '../../../global/constants/app_colors.dart';
import '../../camera_translate/view/camera_translate_view.dart';
import '../../history/view/widgets/history_card/history_view.dart';
import '../../text_translate/view/text_translate_view.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeVm = HomeViewModel();

  late List<Widget> pages;

  void init() {
    pages = [
      CameraTranslateView(),
      TextTranslateView(),
      const HistoryView(),
      const SettingsView(),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (globalVm.isPremium) return;
      globalVm.showPaywall(context);
    });
  }

  Color selectedColor = const Color.fromARGB(255, 224, 223, 226);
  Color unselectedColor = const Color.fromARGB(255, 152, 149, 156);

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: homeVm.pageController,
          children: pages,
        ),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return BottomNavigationBar(
          backgroundColor: AppColors.darkBackground,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          selectedIconTheme: IconThemeData(color: selectedColor),
          unselectedIconTheme: IconThemeData(color: unselectedColor),
          selectedLabelStyle: TextStyle(color: selectedColor),
          unselectedItemColor: unselectedColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.camera),
              backgroundColor: AppColors.darkBackground,
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.doc_text),
              backgroundColor: AppColors.darkBackground,
              label: 'Text',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              backgroundColor: AppColors.darkBackground,
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              backgroundColor: AppColors.darkBackground,
              label: 'Settings',
            ),
          ],
          currentIndex: homeVm.selectedPageIndex,
          onTap: (index) => homeVm.changeSelectedPageIndex(index),
        );
      }),
    );
  }
}
