// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'dart:ui' as ui show Image;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_translator/global/helper/gallery_image_picker.dart';
import 'package:photo_translator/global/helper/hive/hive_adapters/history_adapter.dart';
import 'package:photo_translator/main.dart';

import '../../../global/helper/alerts/remaining_photo_credit_alert.dart';

part 'camera_translate_view_model.g.dart';

class CameraTranslateViewModel = _CameraTranslateViewModelBase
    with _$CameraTranslateViewModel;

abstract class _CameraTranslateViewModelBase with Store {
  XFile? takedPicture;

  @observable
  File? takedPictureAsFile;

  @observable
  bool isLoading = false;

  void setTakedPictureAsFile(File file) => takedPictureAsFile = file;

  void changeIsLoading(bool value) => isLoading = value;

  Future<void> prepareForSavedImage(HistoryModel historyModel) async {
    setTakedPictureAsFile(File(historyModel.imagePath!));
    await recognizeText(historyModel: historyModel);
  }

  @action
  void clearTakedPictureAsFile() => takedPictureAsFile = null;

  void clearState() {
    clearTakedPictureAsFile();
    globalVm.clearLastTranslatedText();
    saveHistoryModel = null;
  }

  late BuildContext contextt;
  void setContext(BuildContext context) => contextt = context;

  double calculatedWidthRatio = 1;
  double calculatedHeightRatio = 1;

  int? mainWidth;
  int? mainHeight;

  double? get dividedMainWidth => mainWidth!.toDouble() / 1;
  double? get dividedMainHeight => mainHeight!.toDouble() / 1;

  GlobalKey cameraPreviewGlobalKey = GlobalKey();

  @observable
  FlashMode cameraFlashState = FlashMode.off;

  void changeCameraFlashState(FlashMode mode) => cameraFlashState = mode;

  void openOrCloseFlashlight({FlashMode? flashMode}) {
    if (flashMode != null) {
      globalVm.cameraController!.setFlashMode(flashMode);
      changeCameraFlashState(flashMode);
      return;
    }
    if (globalVm.cameraController!.value.flashMode == FlashMode.off) {
      globalVm.cameraController!.setFlashMode(FlashMode.torch);
      changeCameraFlashState(FlashMode.torch);
    } else {
      globalVm.cameraController!.setFlashMode(FlashMode.off);
      changeCameraFlashState(FlashMode.off);
    }
  }

  @observable
  ObservableList<Widget> positionedTextWidgets = ObservableList.of([]);
  @observable
  ObservableList<Widget> positionedLineWidgets = ObservableList.of([]);
  @observable
  ObservableList<Widget> positionedBlockWidgets = ObservableList.of([]);

  List<String> sourceTextByWord = [];
  List<String> sourceTextByLine = [];
  List<String> sourceTextByBlock = [];

  @observable
  bool isPhotoTaking = false;

  @action
  void changeIsPhotoTakingState(bool value) => isPhotoTaking = value;

  void afterTakePicture() {
    openOrCloseFlashlight(flashMode: FlashMode.off);
    globalVm.changeShowScannedTextOverlayState(state: true);
  }

  Future<void> takePictureFromCamera() async {
    bool hasInternet = await globalVm.checkInternet(contextt);
    if (!hasInternet) return;

    await takePicture(
      imageGetter: () async => await globalVm.cameraController!.takePicture(),
    );
  }

  Future<void> takePicture({
    required Future<XFile?> Function() imageGetter,
    String? errorStr,
  }) async {
    if (!(globalVm.isPremium)) {
      if (await globalVm.getRemainingCameraTranslation() <= 0) {
        showNoMorePhotoCreditDialog(contextt);
        return;
      }
    }
    if (takedPictureAsFile != null) {
      takedPictureAsFile = null;
      positionedTextWidgets.clear();
      print('cam123 no take picture');
      return;
    }
    changeIsPhotoTakingState(true);
    print('cam123 taking picture');
    try {
      XFile? picture = await imageGetter();
      takedPicture = picture;
      getTextsFromImage(picture!.path);
      takedPictureAsFile = File(takedPicture!.path);
      print('a8321 picture taken');
      if (globalVm.isPremium) return;
      globalVm
          .decreaseRemainingCameraTranslation()
          .then((value) => showRemainingCreditCountDialog(contextt));
    } catch (e) {
      String error = errorStr ?? 'camera picture error:';
      print('a8321 $error $e');
    }
    afterTakePicture();
    changeIsPhotoTakingState(false);
  }

  Future<void> getTextsFromImage(String imagePath) async {
    try {
      await recognizeText(inputImage: InputImage.fromFile(File(imagePath)));
      //recognizedTextStr = recognizedText.text;
      print('a8321 text recognized');
    } catch (e) {
      print('a8321 error: $e');
    }
  }

  Future<void> getImageFromGallery() async {
    openOrCloseFlashlight(flashMode: FlashMode.off);
    await takePicture(
      imageGetter: () async => await GalleryImagePicker.getImageFromGallery(),
    );
  }

  Future<void> setMainWidthAndHeight() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      mainWidth = cameraPreviewGlobalKey.currentContext!.size!.width.toInt();
      mainHeight = cameraPreviewGlobalKey.currentContext!.size!.height.toInt();
      print('kdsakda $mainWidth - $mainHeight');
    } catch (e) {
      int kBottomNavigationBarHeightInt = kBottomNavigationBarHeight.toInt();
      int width = MediaQuery.sizeOf(contextt).width.toInt();
      int height = MediaQuery.sizeOf(contextt).height.toInt();
      mainWidth = width;
      mainHeight = height - (kBottomNavigationBarHeightInt + 20);
      print('kdsakda | mainHeight: $mainHeight error: $e');
    }
  }

  void calculateWidthAndHeightRatio(ui.Image decodedImage) {
    int phoneWidth = mainWidth ?? MediaQuery.of(contextt).size.width.toInt();
    int phoneHeight = mainHeight ?? MediaQuery.of(contextt).size.height.toInt();

    //? Üretilen textlerin pozisyonları hatalı olursa burayı aç ve dividedMainWidth ve dividedMainHeight'i 1.1'e böl.
    //phoneWidth = phoneWidth ~/ 1.1;
    //phoneHeight = phoneHeight ~/ 1.1;

    print('phoneSize8321 $phoneWidth - $phoneHeight');

    int imageWidth = decodedImage.width;
    int imageHeight = decodedImage.height;

    calculatedWidthRatio = imageWidth / phoneWidth;
    calculatedHeightRatio = imageHeight / phoneHeight;
  }

  /// inputImage: Kameradan fotoğraf çekilmiş ya da galeriden alınmış fotoğraf için. | historyModel: Kaydedilmiş bir fotoğraf için.
  Future<void> recognizeText({
    InputImage? inputImage,
    HistoryModel? historyModel,
  }) async {
    positionedTextWidgets.clear();
    positionedLineWidgets.clear();
    positionedBlockWidgets.clear();

    sourceTextByWord.clear();
    sourceTextByLine.clear();
    sourceTextByBlock.clear();

    recognizedTextAsStr = '';

    RecognizedText? recognizedText;
    List<TextBlock>? blocks;
    if (inputImage != null) {
      recognizedText = await TextRecognizer().processImage(inputImage);
      blocks = recognizedText.blocks;
    }

    var takedPicturePath =
        historyModel != null ? historyModel.imagePath : takedPicture!.path;

    ui.Image decodedImage =
        await decodeImageFromList(File(takedPicturePath!).readAsBytesSync());

    calculateWidthAndHeightRatio(decodedImage);

    List<List<Widget>> recognizedTextWidgetList = historyModel != null
        ? getRecognizedTextWidgetLists(
            isHistory: true, historModel: historyModel)
        : getRecognizedTextWidgetLists(blocks: blocks);

    List<Widget> positionedBlockWidgetsHere = recognizedTextWidgetList[0];
    List<Widget> positionedLineWidgetsHere = recognizedTextWidgetList[1];
    List<Widget> positionedTextWidgetsHere = recognizedTextWidgetList[2];

    positionedTextWidgets = ObservableList.of(positionedTextWidgetsHere);
    positionedLineWidgets = ObservableList.of(positionedLineWidgetsHere);
    positionedBlockWidgets = ObservableList.of(positionedBlockWidgetsHere);

    print('p3921 recognized text: $recognizedTextAsStr');
  }

  List<List<Widget>> getRecognizedTextWidgetLists({
    List<TextBlock>? blocks,
    bool isHistory = false,
    HistoryModel? historModel,
  }) {
    List<Widget> positionedBlockWidgetsHere = [];
    List<Widget> positionedLineWidgetsHere = [];
    List<Widget> positionedTextWidgetsHere = [];

    List<TextBlock> textBlocks = [];
    List<TextLine> textLines = [];
    List<TextElement> textElements = [];

    if (isHistory) {
      for (var block in historModel!.positionedBlockWidgets) {
        positionedBlockWidgetsHere.add(buildPositionedWidget(
          x: block.x,
          y: block.y,
          angle: block.angle,
          width: block.width,
          height: block.height,
          text: block.text,
        ));
        recognizedTextAsStr += '${block.text}\n';
        sourceTextByBlock.add('${block.text}\n');
      }
      for (var line in historModel.positionedLineWidgets) {
        positionedLineWidgetsHere.add(buildPositionedWidget(
          x: line.x,
          y: line.y,
          angle: line.angle,
          width: line.width,
          height: line.height,
          text: line.text,
        ));
        sourceTextByLine.add('${line.text}\n');
      }
      for (var text in historModel.positionedTextWidgets) {
        positionedTextWidgetsHere.add(buildPositionedWidget(
          x: text.x,
          y: text.y,
          angle: text.angle,
          width: text.width,
          height: text.height,
          text: text.text,
        ));
        sourceTextByWord.add('${text.text}\n');
      }
    } else {
      for (var block in blocks!) {
        positionedBlockWidgetsHere.add(getWidgetForBlock(block));
        textBlocks.add(block);
        sourceTextByBlock.add('${block.text}\n');
        for (var line in block.lines) {
          positionedLineWidgetsHere.add(getWidgetForLine(line));
          textLines.add(line);
          recognizedTextAsStr += '${line.text}\n';
          sourceTextByLine.add('${line.text}\n');
          for (var textElement in line.elements) {
            positionedTextWidgetsHere.add(getWidgetForText(textElement));
            textElements.add(textElement);
            sourceTextByWord.add('${textElement.text}\n');
          }
        }
      }

      saveHistoryModel = SaveHistoryModel(
        imagePath: takedPictureAsFile!.path,
        textBlocks: textBlocks,
        textLines: textLines,
        textElements: textElements,
      );
    }
    return [
      positionedBlockWidgetsHere,
      positionedLineWidgetsHere,
      positionedTextWidgetsHere,
    ];
  }

  String recognizedTextAsStr = '';

  SaveHistoryModel? saveHistoryModel;

  Widget getWidgetForBlock(TextBlock block) {
    return buildPositionedWidget(
      text: block.text,
      x: block.cornerPoints.first.x,
      y: block.cornerPoints.first.y,
      angle: 1,
      width: block.boundingBox.width,
      height: block.boundingBox.height,
    );
  }

  Widget getWidgetForLine(TextLine line) {
    return buildPositionedWidget(
      text: line.text,
      x: line.cornerPoints.first.x,
      y: line.cornerPoints.first.y,
      angle: line.angle!,
      width: line.boundingBox.width,
      height: line.boundingBox.height,
    );
  }

  Widget getWidgetForText(TextElement textElement) {
    return buildPositionedWidget(
      text: textElement.text,
      x: textElement.cornerPoints.first.x,
      y: textElement.cornerPoints.first.y,
      angle: textElement.angle!,
      width: textElement.boundingBox.width,
      height: textElement.boundingBox.height,
    );
  }

  String getRecognizedTextStr(Widget widget) {
    return (((((((((widget as Positioned).child as Observer).builder(contextt))
                            as SizedBox)
                        .child as RotationTransition)
                    .child) as FittedBox)
                .child as Container)
            .child as Text)
        .data!;
  }

  Widget buildPositionedWidget({
    required int x,
    required int y,
    required double angle,
    required double width,
    required double height,
    required String text,
  }) {
    return Positioned(
      left: x / calculatedWidthRatio,
      top: y / calculatedHeightRatio,
      child: Observer(builder: (_) {
        return SizedBox(
          width: width / calculatedWidthRatio,
          height: height / calculatedHeightRatio,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(angle / 360),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                color: globalVm.scannedTextBackgroundColor,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: globalVm.scannedTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class SaveHistoryModel {
  final String imagePath;
  final List<TextBlock> textBlocks;
  final List<TextLine> textLines;
  final List<TextElement> textElements;

  SaveHistoryModel({
    required this.imagePath,
    required this.textBlocks,
    required this.textLines,
    required this.textElements,
  });
}
