// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';
import 'package:photo_translator/global/helper/translate_bottom_sheet/translate_bottom_sheet.dart';
import 'package:photo_translator/global/widgets/language_selector_widget.dart';
import 'package:photo_translator/main.dart';
import 'package:photo_translator/view/camera_translate/view/sub_views/image_taken_view/view_model/image_taken_view_model.dart';

import '../../../../view_model/camera_translate_view_model.dart';

class ImageTakenView extends StatefulWidget {
  ImageTakenView({
    super.key,
    required this.cameraTranslateVm,
    this.openBackButton = false,
  });

  final CameraTranslateViewModel cameraTranslateVm;
  final bool openBackButton;

  @override
  State<ImageTakenView> createState() => _ImageTakenViewState();
}

class _ImageTakenViewState extends State<ImageTakenView> {
  ImageTakenViewModel imageTakenVm = ImageTakenViewModel();

  void init(BuildContext context) {
    imageTakenVm.setContext(context);
  }

  CameraTranslateViewModel get cameraTranslateVm => widget.cameraTranslateVm;

  List<Widget> getTranslatedTextWidgets(TranslateShowType type) {
    return type == TranslateShowType.Word
        ? cameraTranslateVm.positionedTextWidgets
        : type == TranslateShowType.Line
            ? cameraTranslateVm.positionedLineWidgets
            : cameraTranslateVm.positionedBlockWidgets;
  }

  @override
  void dispose() {
    cameraTranslateVm.clearState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return SizedBox(
      width: widget.cameraTranslateVm.dividedMainWidth,
      height: widget.cameraTranslateVm.dividedMainHeight,
      child: Observer(builder: (_) {
        return Stack(
          children: [
                takedImageWidget,
                Observer(builder: (_) {
                  return Stack(
                    children: (globalVm.showScannedTextOverlay
                        ? getTranslatedTextWidgets(globalVm.translateShowType)
                        : <Widget>[]),
                  );
                }),
              ] +
              [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 5, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildShowHideOverlayButton(),
                        buildRestartButton(),
                        buildShowTextButton(),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          widget.openBackButton
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: context.width * 0.04,
                                      top: context.height * 0.04,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.7),
                                        borderRadius:
                                            BorderRadius.circular(9999),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(9999),
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: const Icon(
                                              CupertinoIcons.back,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          Expanded(child: LanguageSelectorWidget()),
                        ],
                      ),
                      MenuAnchor(
                        builder: (BuildContext context,
                            MenuController controller, Widget? child) {
                          return CupertinoButton(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.width * 0.09,
                                vertical: context.height * 0.01,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                globalVm.translateShowType.type.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: context.width * 0.036,
                                ),
                              ),
                            ),
                          );
                        },
                        menuChildren: List<MenuItemButton>.generate(
                          3,
                          (int index) => MenuItemButton(
                            onPressed: () {
                              globalVm.changeTranslateShowType(
                                  TranslateShowType.getFromName(
                                      menuItems[index].type));
                              globalVm.changeShowScannedTextOverlayState(
                                  state: true);
                              globalVm.clearLastTranslatedText();
                            },
                            child: Text(menuItems[index].type.toString()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
        );
      }),
    );
  }

  List<TranslateShowType> menuItems = [
    TranslateShowType.Word,
    TranslateShowType.Line,
    TranslateShowType.Paragraph,
  ];

  int selectedMenu = 0;

  Widget get takedImageWidget {
    return Image.file(
      widget.cameraTranslateVm.takedPictureAsFile!,
      width: context.width,
      height: context.height,
      fit: BoxFit.fill,
    );
  }

  Widget get blackBlurWidget {
    return Container(
      width: widget.cameraTranslateVm.dividedMainWidth,
      height: widget.cameraTranslateVm.dividedMainHeight,
      color: Colors.black.withOpacity(.5),
    );
  }

  Widget buildRestartButton() {
    return CupertinoButton(
      onPressed: () => widget.cameraTranslateVm.clearState(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.8),
          borderRadius: BorderRadius.circular(9999),
        ),
        padding: const EdgeInsets.all(10),
        child: FittedBox(
          child: Icon(
            Icons.restart_alt_rounded,
            color: Colors.white.withOpacity(.8),
            size: MediaQuery.sizeOf(context).width * 0.13,
          ),
        ),
      ), //() => cameraTranslateVm.takePicture(),
    );
  }

  Widget buildShowHideOverlayButton() {
    return CupertinoButton(
      onPressed: () => globalVm.changeShowScannedTextOverlayState(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.8),
          borderRadius: BorderRadius.circular(9999),
        ),
        padding: const EdgeInsets.all(10),
        child: Observer(builder: (_) {
          return SvgPicture.asset(
            globalVm.showScannedTextOverlay
                ? 'assets/hide_overlay_icon.svg'
                : 'assets/show_overlay_icon.svg',
            width: MediaQuery.sizeOf(context).width * 0.08,
            color: Colors.white,
          );
        }),
      ), //() => cameraTranslateVm.takePicture(),
    );
  }

  Widget buildShowTextButton() {
    return CupertinoButton(
      onPressed: () => TranslateBottomSheet(
        context: context,
        cameraTranslateVm: cameraTranslateVm,
      ).show(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.8),
          borderRadius: BorderRadius.circular(9999),
        ),
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          'assets/document_icon.svg',
          width: MediaQuery.sizeOf(context).width * 0.08,
          color: Colors.white,
        ),
      ), //() => cameraTranslateVm.takePicture(),
    );
  }
}

enum TranslateShowType {
  Paragraph('Paragraph'),
  Line('Line'),
  Word('Word');

  const TranslateShowType(this.type);

  static TranslateShowType getFromName(String name) {
    switch (name) {
      case 'Paragraph':
        return TranslateShowType.Paragraph;
      case 'Line':
        return TranslateShowType.Line;
      case 'Word':
        return TranslateShowType.Word;
      default:
        return TranslateShowType.Word;
    }
  }

  final String type;
}
