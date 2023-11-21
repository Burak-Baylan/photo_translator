// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_translator/global/helper/hive/hive_constants.dart';
import 'package:photo_translator/main.dart';

import '../../../global/helper/hive/hive_adapters/history_adapter.dart';
import '../../../global/helper/hive/hive_adapters/history_positioned_widget_adapter.dart';

part 'history_view_model.g.dart';

class HistoryViewModel = _HistoryViewModelBase with _$HistoryViewModel;

abstract class _HistoryViewModelBase with Store {
  @observable
  ObservableList<HistoryModel>? allHistory;

  List<HistoryModel>? fixedAllHistory;

  TextEditingController searchController = TextEditingController();

  late BuildContext contextt;

  void setContext(BuildContext context) => contextt = context;

  Future<void> getAllHistory() async {
    allHistory = ObservableList.of(await globalVm.getAllHistory());
    fixedAllHistory = allHistory;
  }

  Future<void> search(String text) async {
    if (text.isEmpty) {
      allHistory = ObservableList.of(fixedAllHistory ?? []);
      return;
    }

    var searchedList = fixedAllHistory?.where((element) {
      String blockText = '';
      for (var element in element.positionedBlockWidgets) {
        blockText += ' ${(element as HistoryPositionedWidgetModel).text}';
      }
      return blockText.toLowerCase().contains(text.toLowerCase());
    });

    allHistory = ObservableList.of((searchedList ?? []).toList());
  }

  void clearSearchText() {
    searchController.clear();
    allHistory = ObservableList.of(fixedAllHistory ?? []);
  }

  Future<void> deleteHistory(HistoryModel model) async {
    await globalVm.hiveHelper.deleteData<HistoryModel>(
      HiveConstants.BOX_USER_HISTORY,
      model.translateFromText == null
          ? model.imagePath
          : model.storedDate.toString(),
    );
    var allHistoryHere = fixedAllHistory;
    allHistoryHere!.removeWhere((element) => element.translateToText == null
        ? element.imagePath == model.imagePath
        : element.storedDate == model.storedDate);
    allHistory = ObservableList.of(allHistoryHere);
    fixedAllHistory = allHistory;
    clearSearchText();
    FocusScope.of(contextt).unfocus();
  }
}
