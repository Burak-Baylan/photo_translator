// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_translate_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CameraTranslateViewModel on _CameraTranslateViewModelBase, Store {
  late final _$takedPictureAsFileAtom = Atom(
      name: '_CameraTranslateViewModelBase.takedPictureAsFile',
      context: context);

  @override
  File? get takedPictureAsFile {
    _$takedPictureAsFileAtom.reportRead();
    return super.takedPictureAsFile;
  }

  @override
  set takedPictureAsFile(File? value) {
    _$takedPictureAsFileAtom.reportWrite(value, super.takedPictureAsFile, () {
      super.takedPictureAsFile = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CameraTranslateViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$cameraFlashStateAtom = Atom(
      name: '_CameraTranslateViewModelBase.cameraFlashState', context: context);

  @override
  FlashMode get cameraFlashState {
    _$cameraFlashStateAtom.reportRead();
    return super.cameraFlashState;
  }

  @override
  set cameraFlashState(FlashMode value) {
    _$cameraFlashStateAtom.reportWrite(value, super.cameraFlashState, () {
      super.cameraFlashState = value;
    });
  }

  late final _$positionedTextWidgetsAtom = Atom(
      name: '_CameraTranslateViewModelBase.positionedTextWidgets',
      context: context);

  @override
  ObservableList<Widget> get positionedTextWidgets {
    _$positionedTextWidgetsAtom.reportRead();
    return super.positionedTextWidgets;
  }

  @override
  set positionedTextWidgets(ObservableList<Widget> value) {
    _$positionedTextWidgetsAtom.reportWrite(value, super.positionedTextWidgets,
        () {
      super.positionedTextWidgets = value;
    });
  }

  late final _$positionedLineWidgetsAtom = Atom(
      name: '_CameraTranslateViewModelBase.positionedLineWidgets',
      context: context);

  @override
  ObservableList<Widget> get positionedLineWidgets {
    _$positionedLineWidgetsAtom.reportRead();
    return super.positionedLineWidgets;
  }

  @override
  set positionedLineWidgets(ObservableList<Widget> value) {
    _$positionedLineWidgetsAtom.reportWrite(value, super.positionedLineWidgets,
        () {
      super.positionedLineWidgets = value;
    });
  }

  late final _$positionedBlockWidgetsAtom = Atom(
      name: '_CameraTranslateViewModelBase.positionedBlockWidgets',
      context: context);

  @override
  ObservableList<Widget> get positionedBlockWidgets {
    _$positionedBlockWidgetsAtom.reportRead();
    return super.positionedBlockWidgets;
  }

  @override
  set positionedBlockWidgets(ObservableList<Widget> value) {
    _$positionedBlockWidgetsAtom
        .reportWrite(value, super.positionedBlockWidgets, () {
      super.positionedBlockWidgets = value;
    });
  }

  late final _$isPhotoTakingAtom = Atom(
      name: '_CameraTranslateViewModelBase.isPhotoTaking', context: context);

  @override
  bool get isPhotoTaking {
    _$isPhotoTakingAtom.reportRead();
    return super.isPhotoTaking;
  }

  @override
  set isPhotoTaking(bool value) {
    _$isPhotoTakingAtom.reportWrite(value, super.isPhotoTaking, () {
      super.isPhotoTaking = value;
    });
  }

  late final _$_CameraTranslateViewModelBaseActionController =
      ActionController(name: '_CameraTranslateViewModelBase', context: context);

  @override
  void clearTakedPictureAsFile() {
    final _$actionInfo =
        _$_CameraTranslateViewModelBaseActionController.startAction(
            name: '_CameraTranslateViewModelBase.clearTakedPictureAsFile');
    try {
      return super.clearTakedPictureAsFile();
    } finally {
      _$_CameraTranslateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsPhotoTakingState(bool value) {
    final _$actionInfo =
        _$_CameraTranslateViewModelBaseActionController.startAction(
            name: '_CameraTranslateViewModelBase.changeIsPhotoTakingState');
    try {
      return super.changeIsPhotoTakingState(value);
    } finally {
      _$_CameraTranslateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
takedPictureAsFile: ${takedPictureAsFile},
isLoading: ${isLoading},
cameraFlashState: ${cameraFlashState},
positionedTextWidgets: ${positionedTextWidgets},
positionedLineWidgets: ${positionedLineWidgets},
positionedBlockWidgets: ${positionedBlockWidgets},
isPhotoTaking: ${isPhotoTaking}
    ''';
  }
}
