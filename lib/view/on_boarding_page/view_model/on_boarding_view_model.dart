import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_translator/main.dart';
import 'package:photo_translator/view/home/view/home_view.dart';
part 'on_boarding_view_model.g.dart';

class OnBoardingViewModel = _OnBoardingViewModelBase with _$OnBoardingViewModel;

abstract class _OnBoardingViewModelBase with Store {
  PageController pageController = PageController();

  late BuildContext contextt;
  bool popAfterDone = false;

  @observable
  int currentPage = 0;

  @action
  void changePage(int pageIndex) => currentPage = pageIndex;

  void setContext(BuildContext context) => contextt = context;

  void init(bool popAfterDone) {
    this.popAfterDone = popAfterDone;
  }

  void nextPage() {
    if (currentPage == 2) {
      navigateToHome();
      return;
    }
    changePage(currentPage + 1);
    animateToPage();
  }

  void previousPage() {
    if (currentPage == 0 || currentPage == 4) {
      navigateToHome();
      return;
    }
    changePage(currentPage - 1);
    animateToPage();
  }

  void navigateToHome() {
    if (popAfterDone) {
      Navigator.pop(contextt);
      return;
    }
    Navigator.pushReplacement(
      contextt,
      MaterialPageRoute(builder: (c) => HomeView()),
    );
  }

  void animateToPage() {
    pageController.animateToPage(
      currentPage,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
    );
  }
}
