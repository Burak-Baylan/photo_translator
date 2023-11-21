// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_translate_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TextTranslateViewModel on _TextTranslateViewModelBase, Store {
  late final _$translatedTextAtom = Atom(
      name: '_TextTranslateViewModelBase.translatedText', context: context);

  @override
  String? get translatedText {
    _$translatedTextAtom.reportRead();
    return super.translatedText;
  }

  @override
  set translatedText(String? value) {
    _$translatedTextAtom.reportWrite(value, super.translatedText, () {
      super.translatedText = value;
    });
  }

  late final _$isTranslatingAtom =
      Atom(name: '_TextTranslateViewModelBase.isTranslating', context: context);

  @override
  bool get isTranslating {
    _$isTranslatingAtom.reportRead();
    return super.isTranslating;
  }

  @override
  set isTranslating(bool value) {
    _$isTranslatingAtom.reportWrite(value, super.isTranslating, () {
      super.isTranslating = value;
    });
  }

  late final _$isTranslatedWidgetVisibleAtom = Atom(
      name: '_TextTranslateViewModelBase.isTranslatedWidgetVisible',
      context: context);

  @override
  bool get isTranslatedWidgetVisible {
    _$isTranslatedWidgetVisibleAtom.reportRead();
    return super.isTranslatedWidgetVisible;
  }

  @override
  set isTranslatedWidgetVisible(bool value) {
    _$isTranslatedWidgetVisibleAtom
        .reportWrite(value, super.isTranslatedWidgetVisible, () {
      super.isTranslatedWidgetVisible = value;
    });
  }

  late final _$selectedTranslateFromLanguageForLanguageSelectorAtom = Atom(
      name:
          '_TextTranslateViewModelBase.selectedTranslateFromLanguageForLanguageSelector',
      context: context);

  @override
  LanguageModel? get selectedTranslateFromLanguageForLanguageSelector {
    _$selectedTranslateFromLanguageForLanguageSelectorAtom.reportRead();
    return super.selectedTranslateFromLanguageForLanguageSelector;
  }

  @override
  set selectedTranslateFromLanguageForLanguageSelector(LanguageModel? value) {
    _$selectedTranslateFromLanguageForLanguageSelectorAtom.reportWrite(
        value, super.selectedTranslateFromLanguageForLanguageSelector, () {
      super.selectedTranslateFromLanguageForLanguageSelector = value;
    });
  }

  late final _$selectedTranslateToLanguageForLanguageSelectorAtom = Atom(
      name:
          '_TextTranslateViewModelBase.selectedTranslateToLanguageForLanguageSelector',
      context: context);

  @override
  LanguageModel? get selectedTranslateToLanguageForLanguageSelector {
    _$selectedTranslateToLanguageForLanguageSelectorAtom.reportRead();
    return super.selectedTranslateToLanguageForLanguageSelector;
  }

  @override
  set selectedTranslateToLanguageForLanguageSelector(LanguageModel? value) {
    _$selectedTranslateToLanguageForLanguageSelectorAtom.reportWrite(
        value, super.selectedTranslateToLanguageForLanguageSelector, () {
      super.selectedTranslateToLanguageForLanguageSelector = value;
    });
  }

  late final _$selectedTranslateFromLanguageAtom = Atom(
      name: '_TextTranslateViewModelBase.selectedTranslateFromLanguage',
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
      name: '_TextTranslateViewModelBase.selectedTranslateToLanguage',
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

  late final _$_TextTranslateViewModelBaseActionController =
      ActionController(name: '_TextTranslateViewModelBase', context: context);

  @override
  void changeTranslatedText(String text) {
    final _$actionInfo = _$_TextTranslateViewModelBaseActionController
        .startAction(name: '_TextTranslateViewModelBase.changeTranslatedText');
    try {
      return super.changeTranslatedText(text);
    } finally {
      _$_TextTranslateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedTranslateToLanguageForLanguageSelector(
      LanguageModel? language) {
    final _$actionInfo = _$_TextTranslateViewModelBaseActionController.startAction(
        name:
            '_TextTranslateViewModelBase.changeSelectedTranslateToLanguageForLanguageSelector');
    try {
      return super
          .changeSelectedTranslateToLanguageForLanguageSelector(language);
    } finally {
      _$_TextTranslateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTranslateFromLanguage(LanguageModel language) {
    final _$actionInfo =
        _$_TextTranslateViewModelBaseActionController.startAction(
            name: '_TextTranslateViewModelBase.changeTranslateFromLanguage');
    try {
      return super.changeTranslateFromLanguage(language);
    } finally {
      _$_TextTranslateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTranslateToLanguage(LanguageModel language) {
    final _$actionInfo =
        _$_TextTranslateViewModelBaseActionController.startAction(
            name: '_TextTranslateViewModelBase.changeTranslateToLanguage');
    try {
      return super.changeTranslateToLanguage(language);
    } finally {
      _$_TextTranslateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
translatedText: ${translatedText},
isTranslating: ${isTranslating},
isTranslatedWidgetVisible: ${isTranslatedWidgetVisible},
selectedTranslateFromLanguageForLanguageSelector: ${selectedTranslateFromLanguageForLanguageSelector},
selectedTranslateToLanguageForLanguageSelector: ${selectedTranslateToLanguageForLanguageSelector},
selectedTranslateFromLanguage: ${selectedTranslateFromLanguage},
selectedTranslateToLanguage: ${selectedTranslateToLanguage}
    ''';
  }
}
