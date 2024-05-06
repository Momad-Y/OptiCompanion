import 'package:flutter_tts/flutter_tts.dart';

class Tts {
  FlutterTts initTts(FlutterTts? flutterTts) {
    flutterTts = FlutterTts();

    _setAwaitOptions(flutterTts);

    setTtsLanguage(flutterTts, "en");
    setTtsSpeed(flutterTts, 3);
    setTtsVolume(flutterTts, 10);
    setTtsGender(flutterTts, "female");

    return flutterTts;
  }

  Future<void> _setAwaitOptions(FlutterTts flutterTts) async {
    await flutterTts.awaitSpeakCompletion(false);
  }

  FlutterTts setTtsLanguage(FlutterTts flutterTts, String language) {
    if (language == "en") {
      language = "en-GB";
    } else if (language == "ar") {
      language = "ar";
    }

    flutterTts.setLanguage(language);

    return flutterTts;
  }

  Future<void> setTtsGender(FlutterTts flutterTts, String gender) async {
    if (gender == "male") {
      await flutterTts.setPitch(0.5);
    } else if (gender == "female") {
      await flutterTts.setPitch(1.0);
    }
  }

  Future<void> setTtsSpeed(FlutterTts flutterTts, int intSpeed) async {
    intSpeed = intSpeed * 2;
    double speed = intSpeed / 10;

    await flutterTts.setSpeechRate(speed);
  }

  Future<void> setTtsVolume(FlutterTts flutterTts, int intVolume) async {
    double volume = intVolume / 10;
    await flutterTts.setVolume(volume);
  }
}
