// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GlobalViewModel on _GlobalViewModelBase, Store {
  Computed<Color>? _$scannedTextBackgroundColorComputed;

  @override
  Color get scannedTextBackgroundColor =>
      (_$scannedTextBackgroundColorComputed ??= Computed<Color>(
              () => super.scannedTextBackgroundColor,
              name: '_GlobalViewModelBase.scannedTextBackgroundColor'))
          .value;
  Computed<Color>? _$blackOpacityFilterColorComputed;

  @override
  Color get blackOpacityFilterColor => (_$blackOpacityFilterColorComputed ??=
          Computed<Color>(() => super.blackOpacityFilterColor,
              name: '_GlobalViewModelBase.blackOpacityFilterColor'))
      .value;

  late final _$removeScannedTextBackgroundAtom = Atom(
      name: '_GlobalViewModelBase.removeScannedTextBackground',
      context: context);

  @override
  bool get removeScannedTextBackground {
    _$removeScannedTextBackgroundAtom.reportRead();
    return super.removeScannedTextBackground;
  }

  @override
  set removeScannedTextBackground(bool value) {
    _$removeScannedTextBackgroundAtom
        .reportWrite(value, super.removeScannedTextBackground, () {
      super.removeScannedTextBackground = value;
    });
  }

  late final _$isPremiumAtom =
      Atom(name: '_GlobalViewModelBase.isPremium', context: context);

  @override
  bool get isPremium {
    _$isPremiumAtom.reportRead();
    return super.isPremium;
  }

  @override
  set isPremium(bool value) {
    _$isPremiumAtom.reportWrite(value, super.isPremium, () {
      super.isPremium = value;
    });
  }

  late final _$showScannedTextOverlayAtom = Atom(
      name: '_GlobalViewModelBase.showScannedTextOverlay', context: context);

  @override
  bool get showScannedTextOverlay {
    _$showScannedTextOverlayAtom.reportRead();
    return super.showScannedTextOverlay;
  }

  @override
  set showScannedTextOverlay(bool value) {
    _$showScannedTextOverlayAtom
        .reportWrite(value, super.showScannedTextOverlay, () {
      super.showScannedTextOverlay = value;
    });
  }

  late final _$selectedTranslateFromLangugeAtom = Atom(
      name: '_GlobalViewModelBase.selectedTranslateFromLanguge',
      context: context);

  @override
  LanguageModel get selectedTranslateFromLanguge {
    _$selectedTranslateFromLangugeAtom.reportRead();
    return super.selectedTranslateFromLanguge;
  }

  @override
  set selectedTranslateFromLanguge(LanguageModel value) {
    _$selectedTranslateFromLangugeAtom
        .reportWrite(value, super.selectedTranslateFromLanguge, () {
      super.selectedTranslateFromLanguge = value;
    });
  }

  late final _$selectedTranslateToLangugeAtom = Atom(
      name: '_GlobalViewModelBase.selectedTranslateToLanguge',
      context: context);

  @override
  LanguageModel get selectedTranslateToLanguge {
    _$selectedTranslateToLangugeAtom.reportRead();
    return super.selectedTranslateToLanguge;
  }

  @override
  set selectedTranslateToLanguge(LanguageModel value) {
    _$selectedTranslateToLangugeAtom
        .reportWrite(value, super.selectedTranslateToLanguge, () {
      super.selectedTranslateToLanguge = value;
    });
  }

  late final _$translateShowTypeAtom =
      Atom(name: '_GlobalViewModelBase.translateShowType', context: context);

  @override
  TranslateShowType get translateShowType {
    _$translateShowTypeAtom.reportRead();
    return super.translateShowType;
  }

  @override
  set translateShowType(TranslateShowType value) {
    _$translateShowTypeAtom.reportWrite(value, super.translateShowType, () {
      super.translateShowType = value;
    });
  }

  late final _$_GlobalViewModelBaseActionController =
      ActionController(name: '_GlobalViewModelBase', context: context);

  @override
  void changeShowScannedTextOverlayState({bool? state}) {
    final _$actionInfo = _$_GlobalViewModelBaseActionController.startAction(
        name: '_GlobalViewModelBase.changeShowScannedTextOverlayState');
    try {
      return super.changeShowScannedTextOverlayState(state: state);
    } finally {
      _$_GlobalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
removeScannedTextBackground: ${removeScannedTextBackground},
isPremium: ${isPremium},
showScannedTextOverlay: ${showScannedTextOverlay},
selectedTranslateFromLanguge: ${selectedTranslateFromLanguge},
selectedTranslateToLanguge: ${selectedTranslateToLanguge},
translateShowType: ${translateShowType},
scannedTextBackgroundColor: ${scannedTextBackgroundColor},
blackOpacityFilterColor: ${blackOpacityFilterColor}
    ''';
  }
}
