import 'package:flutter/material.dart';

import '../constants/constants.dart';

extension StringExtension on String {
  String capitalize() {
    return length > 0
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');

      String get toSvg => "assets/svg/$this.svg";
  bool get isEmailValid => RegExp(GlobalConstants.EMAIL_REGEX).hasMatch(this);
  String? get emailValidator {
    var text = this;
    if (text.isEmpty) return "Email cannot be empty";
    if (!text.trim().isEmailValid) return "Email not valid";
    return null;
  }

  String? get passwordValidator {
    var text = this;
    if (text.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }

  bool get urlControl => Uri.tryParse(this)?.hasAbsolutePath ?? false;

  Color get convertStringToColor =>
      Color(int.parse((("#" + this).substring(1, 7)), radix: 16) + 0xFF000000);


  bool get isUsernameValid =>
      RegExp(GlobalConstants.USERNAME_REGEX).hasMatch(this);

  bool get isDisplayNameValid =>
      RegExp(GlobalConstants.DISPLAY_NAME_REGEX).hasMatch(this);


  String? get usernameValidator {
    if (isEmpty) {
      return "Username cannot be empty";
    }
    if (!isUsernameValid) {
      return "Username characters can be only alphabets, numbers, or underscores.";
    }
    if (length < 5) {
      return "Username cannot be less than 5 characters";
    }
    if (length > 16) {
      return "Username cannot be greater than 16 characters";
    }
    return null;
  }

  String? get displayNameValidator {
    if (isEmpty) {
      return "Display Name cannot be empty";
    }
    if (!isDisplayNameValid) {
      return "Display Name characters can be only alphabets, numbers, or underscores.";
    }
    if (length < 6) {
      return "Display Name cannot be less than 6 characters";
    }
    if (length > 15) {
      return "Display Name cannot be greater than 15 characters";
    }
    return null;
  }
}
