// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_boarding_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnBoardingViewModel on _OnBoardingViewModelBase, Store {
  late final _$currentPageAtom =
      Atom(name: '_OnBoardingViewModelBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$_OnBoardingViewModelBaseActionController =
      ActionController(name: '_OnBoardingViewModelBase', context: context);

  @override
  void changePage(int pageIndex) {
    final _$actionInfo = _$_OnBoardingViewModelBaseActionController.startAction(
        name: '_OnBoardingViewModelBase.changePage');
    try {
      return super.changePage(pageIndex);
    } finally {
      _$_OnBoardingViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage}
    ''';
  }
}
