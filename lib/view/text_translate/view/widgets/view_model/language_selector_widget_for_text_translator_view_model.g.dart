// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_selector_widget_for_text_translator_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LanguageSelectorWidgetForTextTranslateViewModel
    on _LanguageSelectorWidgetForTextTranslateViewModelBase, Store {
  late final _$selectedTranslateFromLanguageAtom = Atom(
      name:
          '_LanguageSelectorWidgetForTextTranslateViewModelBase.selectedTranslateFromLanguage',
      context: context);

  @override
  LanguageModel get selectedTranslateFromLanguage {
    _$selectedTranslateFromLanguageAtom.reportRead();
    return super.selectedTranslateFromLanguage;
  }

  @override
  set selectedTranslateFromLanguage(LanguageModel value) {
    _$selectedTranslateFromLanguageAtom
        .reportWrite(value, super.selectedTranslateFromLanguage, () {
      super.selectedTranslateFromLanguage = value;
    });
  }

  late final _$selectedTranslateToLanguageAtom = Atom(
      name:
          '_LanguageSelectorWidgetForTextTranslateViewModelBase.selectedTranslateToLanguage',
      context: context);

  @override
  LanguageModel get selectedTranslateToLanguage {
    _$selectedTranslateToLanguageAtom.reportRead();
    return super.selectedTranslateToLanguage;
  }

  @override
  set selectedTranslateToLanguage(LanguageModel value) {
    _$selectedTranslateToLanguageAtom
        .reportWrite(value, super.selectedTranslateToLanguage, () {
      super.selectedTranslateToLanguage = value;
    });
  }

  late final _$_LanguageSelectorWidgetForTextTranslateViewModelBaseActionController =
      ActionController(
          name: '_LanguageSelectorWidgetForTextTranslateViewModelBase',
          context: context);

  @override
  void changeTranslateFromLanguage(LanguageModel language) {
    final _$actionInfo =
        _$_LanguageSelectorWidgetForTextTranslateViewModelBaseActionController
            .startAction(
                name:
                    '_LanguageSelectorWidgetForTextTranslateViewModelBase.changeTranslateFromLanguage');
    try {
      return super.changeTranslateFromLanguage(language);
    } finally {
      _$_LanguageSelectorWidgetForTextTranslateViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeTranslateToLanguage(LanguageModel language) {
    final _$actionInfo =
        _$_LanguageSelectorWidgetForTextTranslateViewModelBaseActionController
            .startAction(
                name:
                    '_LanguageSelectorWidgetForTextTranslateViewModelBase.changeTranslateToLanguage');
    try {
      return super.changeTranslateToLanguage(language);
    } finally {
      _$_LanguageSelectorWidgetForTextTranslateViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedTranslateFromLanguage: ${selectedTranslateFromLanguage},
selectedTranslateToLanguage: ${selectedTranslateToLanguage}
    ''';
  }
}
