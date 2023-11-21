// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_translator/global/constants/app_colors.dart';
import 'package:photo_translator/global/helper/copy_text_helper.dart';
import 'package:photo_translator/main.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../view/camera_translate/view_model/camera_translate_view_model.dart';
import '../text_sharer.dart';
import 'translate_bottom_sheet_helper.dart';

class TranslateBottomSheet {
  final BuildContext context;
  final CameraTranslateViewModel cameraTranslateVm;
  final TranslateBottomSheetHelper bottomSheetHelper =
      TranslateBottomSheetHelper();

  TranslateBottomSheet({
    required this.context,
    required this.cameraTranslateVm,
  }) {
    bottomSheetHelper.setContext(context);
    bottomSheetHelper.setCameraTranslateViewModel(cameraTranslateVm);
  }

  Future<void> show() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return TranslateBottomSheetBody(bottomSheetHelper: bottomSheetHelper);
      },
    );
  }
}

class TranslateBottomSheetBody extends StatefulWidget {
  TranslateBottomSheetBody({super.key, required this.bottomSheetHelper});

  TranslateBottomSheetHelper bottomSheetHelper = TranslateBottomSheetHelper();

  @override
  State<TranslateBottomSheetBody> createState() =>
      _TranslateBottomSheetBodyState();
}

class _TranslateBottomSheetBodyState extends State<TranslateBottomSheetBody> {
  bool firstInit = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.8,
      width: context.width,
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.lightBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    closeSheetButton(false),
                    Container(
                      width: context.width * 0.1,
                      height: context.height * 0.007,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 144, 140, 142),
                      ),
                    ),
                    closeSheetButton(),
                  ],
                ),
                translateFromWidget(),
                const Divider(),
                Center(child: translateToWidget()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCopyButton(),
                buildShareButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShareButton() {
    return globalVm.lastTranslatedText == null
        ? Container()
        : Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(9999),
              onTap: () => share(globalVm.lastTranslatedText!),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  CupertinoIcons.share,
                  color: Colors.white,
                  size: context.width * 0.07,
                ),
              ),
            ),
          );
  }

  Widget buildCopyButton() {
    return globalVm.lastTranslatedText == null
        ? Container()
        : Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(9999),
              onTap: () => copyText(globalVm.lastTranslatedText!),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  CupertinoIcons.doc_on_doc,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }

  Widget closeSheetButton([bool isVisible = true]) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(9999),
        onTap: isVisible ? () => Navigator.pop(context) : null,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Icon(
            CupertinoIcons.xmark_square,
            color: isVisible ? Colors.white : Colors.transparent,
            size: context.width * 0.07,
          ),
        ),
      ),
    );
  }

  Widget translateFromWidget() {
    return buildTextAndLanguageTitle(
      globalVm.selectedTranslateFromLanguge.name,
      widget.bottomSheetHelper.cameraTranslateVm.recognizedTextAsStr,
    );
  }

  bool isTranslating = false;

  Widget translateToWidget() {
    return isTranslating
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: context.height * 0.03),
              const CupertinoActivityIndicator(color: Colors.white),
              SizedBox(height: context.height * 0.02),
              const Text(
                'Translating',
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        : globalVm.lastTranslatedText != null
            ? buildTextAndLanguageTitle(
                globalVm.selectedTranslateToLanguge.name,
                globalVm.lastTranslatedText!,
              )
            : Theme(
                data: ThemeData(),
                child: TextButton(
                  onPressed: () {
                    setState(() => isTranslating = true);
                    widget.bottomSheetHelper.translateText().then((value) {
                      isTranslating = false;
                      widget.bottomSheetHelper.save();
                      setState(() {});
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Translate',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: context.width * 0.02),
                      const Icon(
                        Icons.translate_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
  }

  Widget buildTextAndLanguageTitle(String title, String text) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 144, 140, 142),
              fontSize: context.width * 0.035,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: context.height / 4,
            child: SingleChildScrollView(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 190, 187, 189),
                  fontSize: context.width * 0.04,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
