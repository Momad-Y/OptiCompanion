import 'package:flutter_tts/flutter_tts.dart';

Tts mainTts = Tts();

class Tts {
  String _language = "Arabic";
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

  Future<void> _setAwaitOptions(FlutterTts flutterTts, bool value) async {
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

    await flutterTts.setSpeechRate(speed);
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
