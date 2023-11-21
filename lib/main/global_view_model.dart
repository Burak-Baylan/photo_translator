// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_translator/global/constants/app_constant.dart';
import 'package:photo_translator/global/helper/get_storage_helper.dart';
import 'package:photo_translator/paywall/view/paywall_view.dart';
import 'package:photo_translator/view/history/view/widgets/history_card/view_model/history_card_view_model.dart';
import '../global/helper/hive/hive_adapters/country_model_adapter.dart';
import '../global/helper/hive/hive_adapters/history_adapter.dart';
import '../global/helper/hive/hive_adapters/history_positioned_widget_adapter.dart';
import '../global/helper/hive/hive_constants.dart';
import '../global/helper/hive/hive_helper.dart';
import '../main.dart';
import '../view/camera_translate/view/sub_views/image_taken_view/view/image_taken_view.dart';
import '../view/camera_translate/view_model/camera_translate_view_model.dart';

part 'global_view_model.g.dart';

class GlobalViewModel = _GlobalViewModelBase with _$GlobalViewModel;

abstract class _GlobalViewModelBase with Store {
  @observable
  bool removeScannedTextBackground = false;

  Color get scannedTextColor => Colors.white;

  HiveHelper hiveHelper = HiveHelper.instance;

  FToast toast = FToast();

  FlutterTts tts = FlutterTts();
  HistoryCardViewModel? ttsPlayingHistoryCard;

  String? premiumExpirationDate;

  @observable
  bool isPremium = false;

  void showPaywall([BuildContext? context]) {
    if (globalVm.isPremium) return;
    Navigator.push(
        context ?? contextt, MaterialPageRoute(builder: (c) => PaywallView()));
  }

  bool isFirstInit = true;

  Future<void> setFirstInit(int state) async => await hiveHelper.putData<int>(
      HiveConstants.BOX_GENERAL, 'isFirstInit', state);

  Future<bool> getFirstInit() async {
    int? isFirstInit =
        await hiveHelper.getData<int>(HiveConstants.BOX_GENERAL, 'isFirstInit');
    bool isFirstInitBool = isFirstInit != null ? (isFirstInit == 1) : true;
    this.isFirstInit = isFirstInitBool;
    return isFirstInitBool;
  }

  void changeIsPremiumState(bool state) => isPremium = state;

  late BuildContext contextt;

  void setContext(BuildContext context) => contextt = context;

  void setTtsPlayingHistoryCard(HistoryCardViewModel? historyCardViewModel) =>
      ttsPlayingHistoryCard = historyCardViewModel;

  void stopTts() {
    tts.stop();
    if (ttsPlayingHistoryCard == null) return;
    ttsPlayingHistoryCard!.stopRead();
  }

  @computed
  Color get scannedTextBackgroundColor =>
      removeScannedTextBackground ? Colors.white : Colors.black.withOpacity(.8);

  @computed
  Color get blackOpacityFilterColor => removeScannedTextBackground
      ? Colors.black.withOpacity(.6)
      : Colors.transparent;

  @observable
  bool showScannedTextOverlay = true;

  @observable
  LanguageModel selectedTranslateFromLanguge = LanguageModel(
    name: 'Automatic',
    code: 'auto',
  );

  @observable
  LanguageModel selectedTranslateToLanguge = LanguageModel(
    name: 'English',
    code: 'en',
  );

  void changeTranslateFromLanguage(LanguageModel countryModel) =>
      selectedTranslateFromLanguge = countryModel;

  void changeTranslateToLanguage(LanguageModel countryModel) =>
      selectedTranslateToLanguge = countryModel;

  @observable
  TranslateShowType translateShowType = TranslateShowType.Word;

  void changeTranslateShowType(TranslateShowType type) =>
      translateShowType = type;

  @action
  void changeShowScannedTextOverlayState({bool? state}) =>
      showScannedTextOverlay = state ?? !showScannedTextOverlay;

  String? lastTranslatedText;

  void clearLastTranslatedText() => lastTranslatedText = null;

  void setLastTranslatedText(String text) => lastTranslatedText = text;

  void init(BuildContext context) {
    setContext(context);
    toast.init(context);
  }

  void saveForText(HistoryModel model) {
    hiveHelper.putData<HistoryModel>(
      HiveConstants.BOX_USER_HISTORY,
      model.storedDate.toString(),
      model,
    );
  }

  void save({
    SaveHistoryModel? imageSaveModel,
    HistoryModel? textSaveModel,
  }) {
    if (imageSaveModel == null) {
      if (textSaveModel == null) return;
      saveForText(textSaveModel);
      return;
    }
    List<HistoryPositionedWidgetModel> positionedWidgetAsBlocks = [];
    List<HistoryPositionedWidgetModel> positionedWidgetAsLines = [];
    List<HistoryPositionedWidgetModel> positionedWidgetAsElements = [];
    imageSaveModel.textBlocks.forEach((element) {
      positionedWidgetAsBlocks.add(
        HistoryPositionedWidgetModel(
          x: element.cornerPoints.first.x,
          y: element.cornerPoints.first.y,
          width: element.boundingBox.width,
          height: element.boundingBox.height,
          text: element.text,
          angle: 1,
        ),
      );
    });
    imageSaveModel.textLines.forEach((element) {
      positionedWidgetAsLines.add(
        HistoryPositionedWidgetModel(
          x: element.cornerPoints.first.x,
          y: element.cornerPoints.first.y,
          width: element.boundingBox.width,
          height: element.boundingBox.height,
          text: element.text,
          angle: element.angle ?? 1,
        ),
      );
    });
    imageSaveModel.textElements.forEach((element) {
      positionedWidgetAsElements.add(
        HistoryPositionedWidgetModel(
          x: element.cornerPoints.first.x,
          y: element.cornerPoints.first.y,
          width: element.boundingBox.width,
          height: element.boundingBox.height,
          text: element.text,
          angle: element.angle ?? 1,
        ),
      );
    });
    hiveHelper.putData<HistoryModel>(
      HiveConstants.BOX_USER_HISTORY,
      imageSaveModel.imagePath,
      HistoryModel(
        imagePath: imageSaveModel.imagePath,
        storedDate: DateTime.now(),
        positionedBlockWidgets: positionedWidgetAsBlocks,
        positionedLineWidgets: positionedWidgetAsLines,
        positionedTextWidgets: positionedWidgetAsElements,
        fromLanguageModel: globalVm.selectedTranslateFromLanguge,
        toLanguageModel: globalVm.selectedTranslateToLanguge,
        translateToText: null,
      ),
    );
  }

  Future<List<HistoryModel>> getAllHistory() async {
    List<HistoryModel> data =
        await hiveHelper.getAll<HistoryModel>(HiveConstants.BOX_USER_HISTORY);
    data.sort((a, b) => b.storedDate.compareTo(a.storedDate));
    return data;
  }

  //? 0 rear camera, 1 front camera
  int currentCamera = 0;
  late List<CameraDescription> cameras;
  late CameraDescription fixedCameraDescription;
  CameraController? cameraController;

  Future<void> startCamera() async {
    try {
      cameras = await availableCameras();
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      await cameraController!
          .initialize()
          .catchError((e) => print('al9321  catch error: $e'));
      fixedCameraDescription = cameraController!.description;
      print('al9321 camera initialized');
    } catch (e) {
      print('al9321 girilemedi: $e');
    }
  }

  Future<bool> checkInternet(BuildContext context,
      [bool showAlert = true]) async {
    var isConnectedInternet = await InternetConnectionChecker().hasConnection;
    if (!isConnectedInternet && showAlert) {
      showNoInternetDialog(context);
    }
    return isConnectedInternet;
  }

  Future<void> showNoInternetDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No internet connection'),
        content: Text('Please check your internet connection'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<int> getRemainingCameraTranslation() async {
    var count = await HiveHelper.instance.getData<int>(
            HiveConstants.BOX_GENERAL, 'remaining_photo_translation') ??
        10;
    return count;
  }

  Future<void> decreaseRemainingCameraTranslation() async {
    int remaining = await getRemainingCameraTranslation();
    HiveHelper.instance.putData(HiveConstants.BOX_GENERAL,
        'remaining_photo_translation', remaining - 1);
  }
}
