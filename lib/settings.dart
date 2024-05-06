import 'package:flutter/material.dart';

class AppSettings {
  BuildContext context;

  AppSettings(this.context);

  int _textSize = 2;

  bool _isMagnifierEnabled = false;

  int _theme = 0;

  int get getTextSize => _textSize;

  bool get getIsMagnifierEnabled => _isMagnifierEnabled;

  int get getTheme => _theme;

  set setTextSize(int textSize) {
    if (textSize >= 1 && textSize <= 5) {
      _textSize = textSize;
    }
  }

  set setIsMagnifierEnabled(bool isMagnifierEnabled) {
    _isMagnifierEnabled = isMagnifierEnabled;
  }

  set setTheme(int selectTheme) {
    // Phone's theme
    if (selectTheme == 0) {
      _theme = 0;
    }
    // Light
    else if (selectTheme == 1) {
      _theme = 1;
    }
    // Dark
    else if (selectTheme == 2) {
      _theme = 2;
    }
  }
}
