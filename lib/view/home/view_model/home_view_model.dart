import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_translator/main.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  @observable
  int selectedPageIndex = 0;

  final PageController pageController = PageController();

  void changeSelectedPageIndex(int index) {
    selectedPageIndex = index;
    pageController.jumpToPage(index);
    if (index != 2) {
      globalVm.stopTts();
    }
  }
}
