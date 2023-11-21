// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';
import 'package:photo_translator/global/helper/hive/hive_adapters/country_model_adapter.dart';
import 'package:photo_translator/main.dart';
import '../helper/languages_list_helper/languages_list_selector_bottom_sheet.dart';

class LanguageSelectorWidget extends StatelessWidget {
  LanguageSelectorWidget({
    super.key,
  });

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return buildChangeLanguageRow();
  }

  Widget buildChangeLanguageRow() {
    return Container(
      width: context.width,
      padding: EdgeInsets.only(
        left: context.width * 0.04,
        right: context.width * 0.04,
        top: context.height * 0.040,
      ),
      child: Observer(builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            changeLanguageWidget(
                (globalVm.selectedTranslateFromLanguge).name, true),
            SizedBox(width: context.width * 0.07),
            buildSwipeLanguagesWidget(),
            SizedBox(width: context.width * 0.07),
            changeLanguageWidget(
                (globalVm.selectedTranslateToLanguge).name, false),
          ],
        );
      }),
    );
  }

  Widget buildSwipeLanguagesWidget() {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(.5),
          border: Border.all(color: Colors.white.withOpacity(.3)),
        ),
        padding: EdgeInsets.all(context.width * 0.01),
        child: const Icon(
          Icons.text_rotation_none_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget changeLanguageWidget(
    String text,
    bool isFrom,
  ) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            LanguageModel? country = await LanguageSelectorBottomSheet.show(
              context,
              excludeAutomaticLanguage: !isFrom,
            );
            if (country != null) {
              if (isFrom) {
                globalVm.changeTranslateFromLanguage(country);
              } else {
                globalVm.changeTranslateToLanguage(country);
              }
              globalVm.clearLastTranslatedText();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(.5),
              border: Border.all(color: Colors.white.withOpacity(.3)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.02,
              vertical: context.width * 0.04,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
