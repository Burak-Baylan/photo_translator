import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';
import 'package:photo_translator/global/constants/app_colors.dart';
import 'package:photo_translator/view/text_translate/view/widgets/lanuage_selector_widget_for_text_translate.dart';

import '../../../global/helper/hive/hive_adapters/history_adapter.dart';
import '../view_model/text_translate_view_model.dart';

class TextTranslateView extends StatefulWidget {
  TextTranslateView({
    super.key,
    this.historyModel,
  });

  HistoryModel? historyModel;

  @override
  State<TextTranslateView> createState() => _TextTranslateViewState();
}

class _TextTranslateViewState extends State<TextTranslateView>
    with AutomaticKeepAliveClientMixin {
  TextTranslateViewModel viewModel = TextTranslateViewModel();

  double get heightMargin => context.height * 0.02;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.init(context, widget.historyModel);
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            widget.historyModel == null
                ? Container()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: (context.width * 0.04) - 5,
                        top: context.width * 0.04,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(9999),
                        onTap: () => context.pop,
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
            Observer(builder: (_) {
              print('a8321 rebuilding');
              return LanguageSelectorWidgetForTextTranslate(
                translateFromLanguage:
                    viewModel.selectedTranslateFromLanguageForLanguageSelector,
                translateToLanguage:
                    viewModel.selectedTranslateToLanguageForLanguageSelector,
                onFromLanguageChanged: (language) {
                  viewModel.changeTranslateFromLanguage(language);
                },
                onToLanguageChanged: (language) {
                  print('a8321 changing ${language.name}');
                  viewModel.changeTranslateToLanguage(language);
                },
              );
            }),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.lightBackground,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: context.width * 0.04,
                  vertical: context.width * 0.04,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.04,
                  vertical: context.width * 0.04,
                ),
                child: Column(
                  children: [
                    Expanded(child: buildTranslateFromWidget()),
                    buildTranslatedWidgetBody(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTranslateFromWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildFromLanguageText(),
            buildPasteAndClearWidget(),
          ],
        ),
        buildTranslateFromTextField(),
      ],
    );
  }

  Widget buildTranslatedWidgetBody() {
    return Observer(builder: (context) {
      return viewModel.isTranslatedWidgetVisible
          ? Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildToLanguageText(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: buildTranslatedWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox();
    });
  }

  Widget buildTranslatedWidget() {
    return Observer(builder: (_) {
      if (viewModel.translatedText != null) {
        return Align(
          alignment: Alignment.topLeft,
          child: Text(
            viewModel.translatedText!,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: context.width * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else {
        return Align(
          alignment: Alignment.topCenter,
          child: translateButton(),
        );
      }
    });
  }

  Widget buildTranslateFromTextField() {
    viewModel.initController();
    return Expanded(
      child: Container(
        width: context.width,
        height: context.height,
        margin: EdgeInsets.only(top: heightMargin),
        child: TextField(
          controller: viewModel.translateTextController,
          cursorColor: Colors.white,
          maxLines: null,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: context.width * 0.04,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: 'Translate',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: context.width * 0.04,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildPasteAndClearWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildButtonWithIcon(
          icon: CupertinoIcons.doc_on_clipboard,
          text: 'Paste',
          onTap: viewModel.pasteTextToTextField,
        ),
        const SizedBox(width: 10),
        buildButtonWithIcon(
          icon: CupertinoIcons.delete,
          text: 'Clear',
          onTap: viewModel.clearTextField,
        ),
      ],
    );
  }

  Widget buildToLanguageText() {
    return Observer(builder: (_) {
      return Container(
        margin: EdgeInsets.only(bottom: heightMargin),
        child: Text(
          viewModel.selectedTranslateToLanguage.name,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: context.width * 0.035,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    });
  }

  Widget buildFromLanguageText() {
    return Observer(builder: (_) {
      return Text(
        viewModel.selectedTranslateFromLanguage.name,
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: context.width * 0.035,
          fontWeight: FontWeight.w500,
        ),
      );
    });
  }

  Widget buildButtonWithIcon({
    required IconData icon,
    required String text,
    required Function onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onTap(),
        child: Container(
          margin: const EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.grey.shade500,
                size: context.width * 0.04,
              ),
              SizedBox(width: context.width * 0.01),
              Text(
                text,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: context.width * 0.035,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget translateButton() {
    return Observer(builder: (context) {
      return viewModel.isTranslating
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
          : Theme(
              data: ThemeData(),
              child: TextButton(
                onPressed: () => viewModel.translate(),
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
    });
  }

  @override
  bool get wantKeepAlive => true;
}
