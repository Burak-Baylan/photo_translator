import 'package:flutter/material.dart';
import 'package:photo_translator/global/constants/app_colors.dart';
import 'package:translator/translator.dart';
import '../../../main.dart';
import '../../../view/camera_translate/view_model/camera_translate_view_model.dart';
import '../hive/hive_adapters/country_model_adapter.dart';

class TranslateBottomSheetHelper {
  late final CameraTranslateViewModel cameraTranslateVm;
  late final BuildContext context;

  void setCameraTranslateViewModel(CameraTranslateViewModel viewModel) {
    cameraTranslateVm = viewModel;
  }

  void setContext(BuildContext context) => this.context = context;

  String? translatedText;

  void save() {
    SaveHistoryModel? savedHistoryModel = cameraTranslateVm.saveHistoryModel;
    if (savedHistoryModel == null) return;
    globalVm.save(imageSaveModel: savedHistoryModel);
  }

  Future<String> translateText() async {
    String? lastTranslatedText = globalVm.lastTranslatedText;
    if (lastTranslatedText != null) return lastTranslatedText;

    final translator = GoogleTranslator();

    String translateFromLanguageCode =
        globalVm.selectedTranslateFromLanguge.code ?? 'auto';

    String translateToLanguageCode =
        globalVm.selectedTranslateToLanguge.code ?? 'en';

    var sourceTextList = getSourceTextList();

    String translatedText = '';

    for (String element in sourceTextList) {
      translatedText += element;
    }

    late Translation translation;

    try {
      translation = await translator.translate(
        translatedText,
        from: translateFromLanguageCode,
        to: translateToLanguageCode,
      );
    } catch (e) {
      try {
        translation = await translator.translate(
          translatedText,
          from: 'auto',
          to: 'en',
        );
      } catch (e) {
        languageNotSupportedAlertDialog();
      }
    }

    translatedText = '${translation.text}\n';

    var sourceLanguage = translation.sourceLanguage;

    globalVm.changeTranslateFromLanguage(
      LanguageModel(name: sourceLanguage.name, code: sourceLanguage.code),
    );

    globalVm.setLastTranslatedText(translatedText);

    this.translatedText = translatedText;

    return translatedText;
  }

  Future<void> languageNotSupportedAlertDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkBackground,
        title: const Text(
          'Language not supported',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: const Text(
          'This language is not supported yet. Please try another language.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  List<String> getSourceTextList() => cameraTranslateVm.sourceTextByBlock;
}
