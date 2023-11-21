import 'package:mobx/mobx.dart';

import '../../../../../global/helper/hive/hive_adapters/country_model_adapter.dart';
part 'language_selector_widget_for_text_translator_view_model.g.dart';

class LanguageSelectorWidgetForTextTranslateViewModel = _LanguageSelectorWidgetForTextTranslateViewModelBase
    with _$LanguageSelectorWidgetForTextTranslateViewModel;

abstract class _LanguageSelectorWidgetForTextTranslateViewModelBase with Store {
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
  }

  @action
  void changeTranslateToLanguage(LanguageModel language) {
    selectedTranslateToLanguage = language;
  }
}
