import 'dart:developer';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Tts mainTts = Tts();

class Tts {
  SharedPreferences? prefs;

  FlutterTts flutterTts = FlutterTts();

  String _language = "Arabic";
  int _speed = 3;
  double _modifiedSpeed = 0.6;
  int _volume = 10;
  String _gender = "Female";

  FlutterTts initTts(bool awaitSpeakCompletion) {
    _setAwaitOptions(awaitSpeakCompletion);

    setTtsLanguage(_language);
    setTtsSpeed(_speed);
    setTtsVolume(_volume);
    setTtsGender(_gender);

    return flutterTts;
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  String getLanguage() {
    if (prefs == null) {
      return _language;
    }
    return prefs!.getString('language') == null ? _language : prefs!.getString('language')!;
  }

  int getSpeed() {
    if (prefs == null) {
      return _speed;
    }
    log('getSpeed: ${prefs!.getInt('speed')}');
    return prefs!.getInt('speed') == null ? _speed : prefs!.getInt('speed')!;
  }

  int getVolume() {
    if (prefs == null) {
      return _volume;
    }
    return prefs!.getInt('volume') == null ? _volume : prefs!.getInt('volume')!;
  }

  String getGender() {
    if (prefs == null) {
      return _gender;
    }
    return prefs!.getString('gender') == null ? _gender : prefs!.getString('gender')!;
  }

  Future<void> _setAwaitOptions(bool value) async {
    await flutterTts.awaitSpeakCompletion(value);
  }

  FlutterTts setTtsLanguage(String language) {
    if (language == "English") {
      language = "en-GB";
      _language = "English";
    } else if (language == "Arabic") {
      language = "ar";
      _language = "Arabic";
    }

    flutterTts.setLanguage(language);
    prefs!.setString('language', _language);
    return flutterTts;
  }

  Future<void> setTtsGender(String gender) async {
    if (gender == "Male") {
      _gender = "Male";
      await flutterTts.setPitch(0.5);
    } else if (gender == "Female") {
      _gender = "Female";
      await flutterTts.setPitch(1.0);
    }
    prefs!.setString('gender', _gender);
  }

  Future<void> setTtsSpeed(int intSpeed) async {
    _speed = intSpeed;
    _modifiedSpeed = (intSpeed * 2) / 10;
    await flutterTts.setSpeechRate(_modifiedSpeed);

    prefs!.setInt('speed', _speed);
    log('setModspeed: $_modifiedSpeed');
    log('set_speed: $_speed');
  }

  Future<void> setTtsVolume(int intVolume) async {
    double volume = intVolume / 10;
    _volume = intVolume;
    await flutterTts.setVolume(volume);
    prefs!.setInt('volume', _volume);
  }
}
