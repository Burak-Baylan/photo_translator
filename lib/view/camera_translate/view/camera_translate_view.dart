// ignore_for_file: must_be_immutable

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../global/helper/hive/hive_adapters/history_adapter.dart';
import '../../../global/widgets/language_selector_widget.dart';
import '../../../main.dart';
import '../view_model/camera_translate_view_model.dart';
import 'sub_views/image_taken_view/view/image_taken_view.dart';

class CameraTranslateView extends StatefulWidget {
  CameraTranslateView({
    super.key,
    this.historyModel,
    this.openBackButton = false,
  });

  HistoryModel? historyModel;
  bool openBackButton;

  @override
  State<CameraTranslateView> createState() => _CameraTranslateViewState();
}

class _CameraTranslateViewState extends State<CameraTranslateView>
    with AutomaticKeepAliveClientMixin {
  CameraTranslateViewModel cameraTranslateVm = CameraTranslateViewModel();

  void init(BuildContext context) {
    print('teas cameraTranslateView init');
    cameraTranslateVm.setContext(context);
    //pageInitFuture = cameraTranslateVm.startCamera();
  }

  late Future<void> pageInitFuture;

  late Widget cameraPreview;

  bool isFirstInit = true;

  @override
  void initState() {
    init(context);
    globalVm.clearLastTranslatedText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!isFirstInit) return;
      cameraTranslateVm.changeIsLoading(true);
      await cameraTranslateVm.setMainWidthAndHeight();
      HistoryModel? historyModel = widget.historyModel;
      if (historyModel == null) {
        cameraTranslateVm.changeIsLoading(false);
        return;
      }
      await cameraTranslateVm.prepareForSavedImage(historyModel);
      globalVm.changeTranslateFromLanguage(historyModel.fromLanguageModel);
      globalVm.changeTranslateToLanguage(historyModel.toLanguageModel);
      cameraTranslateVm.changeIsLoading(false);
      isFirstInit = false;
    });
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (contex) {
            if (globalVm.cameraController != null) {
              setCameraPreview();
              return Observer(builder: (context) {
                return Stack(
                  children: [
                    buildBody(),
                    cameraTranslateVm.isLoading
                        ? Container(
                            width: context.width,
                            height: context.height,
                            color: Colors.black.withOpacity(.3),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                );
              });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void setCameraPreview() {
    print('p94531 camera setting');
    cameraPreview = CameraPreview(
      globalVm.cameraController!,
      key: cameraTranslateVm.cameraPreviewGlobalKey,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildFlashButton(),
                  buildTakePhotoButton(),
                  buildGalleryButton(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: LanguageSelectorWidget(),
          ),
          Observer(builder: (_) {
            return cameraTranslateVm.takedPictureAsFile != null
                ? Align(
                    alignment: Alignment.center,
                    child: ImageTakenView(
                      cameraTranslateVm: cameraTranslateVm,
                      openBackButton: widget.openBackButton,
                    ),
                  )
                : Container();
          }),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: globalVm.cameraController == null
                ? const Text('şuan yok')
                : buildMainBody(),
          ),
        ),
      ],
    );
  }

  Widget buildMainBody() {
    return Container(
      width: context.width,
      height: context.height,
      child: cameraPreview,
    );
  }

  Widget buildTakePhotoButton() {
    return Observer(builder: (_) {
      bool isPhotoTaking = cameraTranslateVm.isPhotoTaking;
      return CupertinoButton(
        onPressed: isPhotoTaking
            ? null
            : () => cameraTranslateVm.takePictureFromCamera(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(isPhotoTaking ? .2 : .8),
            borderRadius: BorderRadius.circular(9999),
          ),
          padding: const EdgeInsets.all(3),
          child: Icon(
            Icons.camera_outlined,
            color: Colors.white.withOpacity(isPhotoTaking ? .2 : 1),
            size: MediaQuery.sizeOf(context).width * 0.17,
          ),
        ), //() => cameraTranslateVm.takePicture(),
      );
    });
  }

  Widget buildFlashButton() {
    return Observer(builder: (_) {
      bool isPhotoTaking = cameraTranslateVm.isPhotoTaking;
      return CupertinoButton(
        onPressed: isPhotoTaking
            ? null
            : () => cameraTranslateVm.openOrCloseFlashlight(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(isPhotoTaking ? .2 : .8),
            borderRadius: BorderRadius.circular(9999),
          ),
          padding: const EdgeInsets.all(10),
          child: FittedBox(
            child: Icon(
              cameraTranslateVm.cameraFlashState == FlashMode.torch
                  ? Icons.flash_on_rounded
                  : Icons.flash_off_rounded,
              color: Colors.white.withOpacity(isPhotoTaking ? .2 : .8),
              size: MediaQuery.sizeOf(context).width * 0.08,
            ),
          ),
        ), //() => cameraTranslateVm.takePicture(),
      );
    });
  }

  Widget buildGalleryButton() {
    return Observer(builder: (_) {
      bool isPhotoTaking = cameraTranslateVm.isPhotoTaking;
      return CupertinoButton(
        onPressed: isPhotoTaking
            ? null
            : () => cameraTranslateVm.getImageFromGallery(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(isPhotoTaking ? .2 : .8),
            borderRadius: BorderRadius.circular(9999),
          ),
          padding: const EdgeInsets.all(10),
          child: FittedBox(
            child: Icon(
              Icons.photo_library_rounded,
              color: Colors.white.withOpacity(isPhotoTaking ? .2 : .8),
              size: MediaQuery.sizeOf(context).width * 0.08,
            ),
          ),
        ), //() => cameraTranslateVm.takePicture(),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
