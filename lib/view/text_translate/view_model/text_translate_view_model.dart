import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_translator/global/helper/alerts/are_you_sure_to_delete_alert.dart';
import 'package:photo_translator/global/helper/copy_text_helper.dart';
import 'package:photo_translator/global/helper/hive/hive_adapters/history_adapter.dart';
import 'package:photo_translator/main.dart';
import 'package:translator/translator.dart';

import '../../../global/helper/hive/hive_adapters/country_model_adapter.dart';
part 'text_translate_view_model.g.dart';

class TextTranslateViewModel = _TextTranslateViewModelBase
    with _$TextTranslateViewModel;

abstract class _TextTranslateViewModelBase with Store {
  TextEditingController translateTextController = TextEditingController();

  late BuildContext contextt;

  void setContext(BuildContext context) => contextt = context;

  void init(BuildContext context, [HistoryModel? historyModel]) {
    setContext(context);
    if (historyModel != null) {
      translateTextController.text = historyModel.translateFromText ?? '';
      print('a8321 text changed $translatedText');
      isTranslatedWidgetVisible = true;
      changeTranslateFromLanguage(historyModel.fromLanguageModel);
      changeTranslateToLanguage(historyModel.toLanguageModel);
      changeSelectedTranslateFromLanguageForLanguageSelector(
          historyModel.fromLanguageModel);
      changeSelectedTranslateToLanguageForLanguageSelector(
          historyModel.toLanguageModel);
      changeTranslatedText(historyModel.translateToText!);
    }
  }

  String get translatingText => translateTextController.text;

  @observable
  String? translatedText;

  void removeTranslatedText() => translatedText = null;

  @observable
  bool isTranslating = false;

  @action
  void changeTranslatedText(String text) => translatedText = text;

  Future<void> translate() async {
    FocusScope.of(globalVm.contextt).unfocus();
    isTranslating = true;
    bool hasInternet = await globalVm.checkInternet(contextt);
    if (!hasInternet) {
      isTranslating = false;
      return;
    }
    final translator = GoogleTranslator();

    String translateFromLanguageCode =
        selectedTranslateFromLanguage.code ?? 'auto';

    String translateToLanguageCode = selectedTranslateToLanguage.code ?? 'en';

    String sourceText = translatingText;

    String translatedText = '';

    late Translation translation;

    try {
      translation = await translator.translate(
        sourceText,
        from: translateFromLanguageCode,
        to: translateToLanguageCode,
      );
    } catch (e) {
      translation = await translator.translate(
        sourceText,
        from: 'auto',
        to: 'en',
      );
    }

    translatedText = '${translation.text}\n';

    var sourceLanguage = translation.sourceLanguage;

    var languageModel = LanguageModel(
      name: sourceLanguage.name,
      code: sourceLanguage.code,
    );

    changeTranslateFromLanguage(languageModel);

    changeSelectedTranslateFromLanguageForLanguageSelector(languageModel);

    changeTranslatedText(translatedText);

    globalVm.save(
      textSaveModel: HistoryModel(
        imagePath: null,
        positionedBlockWidgets: [],
        positionedLineWidgets: [],
        positionedTextWidgets: [],
        storedDate: DateTime.now(),
        fromLanguageModel: selectedTranslateFromLanguage,
        toLanguageModel: selectedTranslateToLanguage,
        translateToText: translatedText,
        translateFromText: sourceText,
      ),
    );

    isTranslating = false;
  }

  @observable
  bool isTranslatedWidgetVisible = false;

  void initController() {
    translateTextController.addListener(() {
      removeTranslatedText();
      if (translateTextController.text.isEmpty) {
        isTranslatedWidgetVisible = false;
        return;
      }
      if (isTranslatedWidgetVisible) return;
      isTranslatedWidgetVisible = true;
    });
  }

  void unfocus() => FocusScope.of(contextt).unfocus();

  Future<void> pasteTextToTextField() async {
    unfocus();
    await showBasicAlertDialog(
      contextt,
      onPositiveButtonPressed: () async {
        translateTextController.text = await textPaster();
      },
      title: 'Are you sure to paste?',
      positiveButtonText: 'Paste',
    );
  }

  Future<void> clearTextField() async {
    unfocus();
    await showBasicAlertDialog(
      contextt,
      onPositiveButtonPressed: () {
        translateTextController.clear();
        setToDefaultFromLanguage();
      },
      title: 'Are you sure to clear?',
      positiveButtonText: 'Clear',
    );
  }

  void setToDefaultFromLanguage() {
    changeTranslateFromLanguage(
      LanguageModel(
        name: 'Automatic',
        code: 'auto',
      ),
    );
  }

  @observable
  LanguageModel? selectedTranslateFromLanguageForLanguageSelector;

  @observable
  LanguageModel? selectedTranslateToLanguageForLanguageSelector;

  @action
  void changeSelectedTranslateToLanguageForLanguageSelector(
      LanguageModel? language) {
    selectedTranslateToLanguageForLanguageSelector = language;
  }

  void changeSelectedTranslateFromLanguageForLanguageSelector(
      LanguageModel? language) {
    selectedTranslateFromLanguageForLanguageSelector = language;
  }

  @observable
  LanguageModel selectedTranslateFromLanguage = LanguageModel(
    name: 'Automatic',
    code: 'auto',
  );

  @observable
  LanguageModel selectedTranslateToLanguage = LanguageModel(
    name: 'English',
    code: 'en',
  );

  @action
  void changeTranslateFromLanguage(LanguageModel language) {
    selectedTranslateFromLanguage = language;
    clearState();
  }

  @action
  void changeTranslateToLanguage(LanguageModel language) {
    selectedTranslateToLanguage = language;
    clearState();
  }

  void clearState() {
    removeTranslatedText();
  }
}
