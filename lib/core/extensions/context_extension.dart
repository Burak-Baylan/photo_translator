import 'package:flutter/material.dart';

extension EasyContext on BuildContext {
  double getHeight(double ratio) => MediaQuery.of(this).size.height * ratio;
  double getWidth(double ratio) => MediaQuery.of(this).size.width * ratio;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  bool get isIpad =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .shortestSide >
      600;

  void get pop => Navigator.of(this).pop();

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size get size => MediaQuery.of(this).size;

  void closeDialog() => Navigator.of(this, rootNavigator: true).pop('dialog');

  void dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(this);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

extension AlerDialogExtensions on BuildContext {
  get closeAlertDialog => Navigator.of(this).pop();
}

extension PaddingExtension on BuildContext {
  EdgeInsets get ultraLowPadding => EdgeInsets.all(ultraLowValue);
  EdgeInsets get lowPadding => EdgeInsets.all(lowValue);
  EdgeInsets get normalPadding => EdgeInsets.all(normalValue);
  EdgeInsets get mediumPadding => EdgeInsets.all(mediumValue);
  EdgeInsets get highPadding => EdgeInsets.all(highValue);
}

extension PaddingAll on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension ValueExtension on BuildContext {
  double get ultraLowValue => height * 0.005;
  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;
}

extension TextStyleExtensions on BuildContext {
  TextStyle get underlinedText =>
      const TextStyle(decoration: TextDecoration.underline);
}
