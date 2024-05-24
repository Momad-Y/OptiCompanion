import 'package:flutter_tts/flutter_tts.dart';

Tts mainTts = Tts();

// TODO: Implement TTS with shared preferences

class Tts {
<<<<<<< HEAD
  SharedPreferences? prefs;

  FlutterTts flutterTts = FlutterTts();

  String _language = "Englist";
=======
  String _language = "Arabic";
>>>>>>> parent of e12bdb3 (Add shared_preferences package and implement preferences for TTS settings)
  int _speed = 3;
  int _volume = 10;
  String _gender = "Female";

  FlutterTts initTts(FlutterTts? flutterTts, bool awaitSpeakCompletion) {
    flutterTts = FlutterTts();

    _setAwaitOptions(flutterTts, awaitSpeakCompletion);

    setTtsLanguage(flutterTts, _language);
    setTtsSpeed(flutterTts, 3);
    setTtsVolume(flutterTts, 10);
    setTtsGender(flutterTts, _gender);

    return flutterTts;
  }

<<<<<<< HEAD
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
=======
  Future<void> _setAwaitOptions(FlutterTts flutterTts, bool value) async {
>>>>>>> parent of e12bdb3 (Add shared_preferences package and implement preferences for TTS settings)
    await flutterTts.awaitSpeakCompletion(value);
  }

  FlutterTts setTtsLanguage(FlutterTts flutterTts, String language) {
    if (language == "English") {
      language = "en-GB";
      _language = "English";
    } else if (language == "Arabic") {
      language = "ar";
      _language = "Arabic";
    }

    flutterTts.setLanguage(language);

    return flutterTts;
  }

  Future<void> setTtsGender(FlutterTts flutterTts, String gender) async {
    if (gender == "Male") {
      _gender = "Male";
      await flutterTts.setPitch(0.5);
    } else if (gender == "Female") {
      _gender = "Female";
      await flutterTts.setPitch(1.0);
    }
  }

  Future<void> setTtsSpeed(FlutterTts flutterTts, int intSpeed) async {
    intSpeed = intSpeed * 2;
    _speed = intSpeed;
    double speed = intSpeed / 10;

<<<<<<< HEAD
    prefs!.setInt('speed', _speed);
=======
    await flutterTts.setSpeechRate(speed);
>>>>>>> parent of e12bdb3 (Add shared_preferences package and implement preferences for TTS settings)
  }

  Future<void> setTtsVolume(FlutterTts flutterTts, int intVolume) async {
    double volume = intVolume / 10;
    _volume = intVolume;
    await flutterTts.setVolume(volume);
  }

  get getLanguage => _language;
  get getSpeed => _speed ~/ 2;
  get getVolume => _volume;
  get getGender => _gender;
}
