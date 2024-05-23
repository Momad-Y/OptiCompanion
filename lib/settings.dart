import 'package:shared_preferences/shared_preferences.dart';

AppSettings mainAppSettings = AppSettings();

class AppSettings {
  SharedPreferences? prefs;

  int _textSize = 2;
  late bool _isMagnifierEnabled = false;
  int _theme = 0;

  int getTextSize() {
    if (prefs == null) {
      return _textSize;
    }
    return prefs!.getInt('text_size') == null ? _textSize : prefs!.getInt('text_size')!;
  }

  bool getIsMagnifierEnabled() {
    if (prefs == null) {
      return _isMagnifierEnabled;
    }
    return prefs!.getBool('is_magnifier_enabled') == null
        ? _isMagnifierEnabled
        : prefs!.getBool('is_magnifier_enabled')!;
  }

  int getTheme() {
    if (prefs == null) {
      return _theme;
    }
    return prefs!.getInt('theme') == null ? _theme : prefs!.getInt('theme')!;
  }

  set setTextSize(int textSize) {
    if (textSize >= 1 && textSize <= 5) {
      _textSize = textSize;
      prefs!.setInt('text_size', _textSize);
    }
  }

  set setIsMagnifierEnabled(bool isMagnifierEnabled) {
    _isMagnifierEnabled = isMagnifierEnabled;
    prefs!.setBool('is_magnifier_enabled', _isMagnifierEnabled);
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
    prefs!.setInt('theme', _theme);
  }

  Future<void> initSettings() async {
    prefs = await SharedPreferences.getInstance();
    getIsMagnifierEnabled();
    getTextSize();
    getTheme();
  }
}
