import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../global/helper/alerts/get_premium_for_listen_to_text_alert.dart';
import '../../../../../../global/helper/hive/hive_adapters/history_adapter.dart';
import '../../../../../../main.dart';

part 'history_card_view_model.g.dart';

class HistoryCardViewModel = _HistoryCardViewModelBase
    with _$HistoryCardViewModel;

abstract class _HistoryCardViewModelBase with Store {
  late String blockText;

  void init(String blockText) {
    this.blockText = historyModel.translateToText ?? blockText;
    setIsAnImageHistory();
  }

  @observable
  bool isTtsPlaying = false;

  void setIsPlayingTrue() => isTtsPlaying = true;

  void setIsPlayingFalse() => isTtsPlaying = false;

  late HistoryCardViewModel thisVm;

  late BuildContext contextt;

  void setContext(BuildContext context) => contextt = context;

  late HistoryModel historyModel;

  void setHistoryModel(HistoryModel historyModel) =>
      this.historyModel = historyModel;

  void setThisHistoryCardViewModel(HistoryCardViewModel historyCardViewModel) =>
      thisVm = historyCardViewModel;

  bool isAnImageHistory = true;

  void setIsAnImageHistory() =>
      isAnImageHistory = historyModel.translateToText == null;

  Future<void> readText() async {
    if (!(globalVm.isPremium)) {
      getPremiumForListenToTextAlertDialog(contextt);
      return;
    }
    await globalVm.tts.speak(blockText);
    setIsPlayingTrue();
    globalVm.setTtsPlayingHistoryCard(thisVm);
    globalVm.tts.setCompletionHandler(() {
      setIsPlayingFalse();
    });
  }

  Future<void> stopRead() async {
    await globalVm.tts.stop();
    setIsPlayingFalse();
  }
}
