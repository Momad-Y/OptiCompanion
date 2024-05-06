import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

import '../settings.dart';

class WelcomeSettingsPage1 extends StatefulWidget {
  const WelcomeSettingsPage1({super.key});

  @override
  State<WelcomeSettingsPage1> createState() => WelcomeSettingsPage1State();
}

class WelcomeSettingsPage1State extends State<WelcomeSettingsPage1> {
  int _counter = 0;
  static const int _maxCounter = 15;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  ThemeMode _themeMode = ThemeMode.system;

  ScrollController controller = ScrollController();

  FlutterTts? flutterTts;

  static List _pageText = [
    "Customize Your Preferences",
    "Select text Size, Current text size is ",
    "Text Size: 1",
    "Text Size: 2",
    "Text Size: 3",
    "Text Size: 4",
    "Text Size: 5",
    "Select theme, Current theme is ",
    "Phone's Theme",
    "Light Theme",
    "Dark Theme",
    "Enable Magnifier, Current setting is ",
    "Disable Magnifier",
    "Enable Magnifier",
    "Previous page",
    "Next page"
  ];

  @override
  initState() {
    super.initState();
    flutterTts = Tts().initTts(flutterTts);
    _speak();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;

      if (_counter > _maxCounter) {
        _counter = 0;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;

      if (_counter < _minCounter) {
        _counter = _maxCounter;
      }
    });
  }

  void _setCounter(int index) {
    setState(() {
      _counter = index;
    });
  }

  Future<void> _speak() async {
    if (_counter == 1) {
      await flutterTts!.speak(_pageText[_counter] + (AppSettings(context).getTextSize.toString()));
    } else if (_counter == 7) {
      await flutterTts!.speak(_pageText[_counter] +
          (AppSettings(context).getTheme == 0
              ? "Phone's theme"
              : AppSettings(context).getTheme == 1
                  ? "Light"
                  : "Dark"));
    } else if (_counter == 11) {
      await flutterTts!
          .speak(_pageText[_counter] + (AppSettings(context).getIsMagnifierEnabled ? "Enabled" : "Disabled"));
    } else {
      await flutterTts!.speak(_pageText[_counter]);
    }
  }

  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          if (_counter == 13) {
            Navigator.pushNamed(context, '/welcome2');
          } else if (_counter == 14) {
            Navigator.pushNamed(context, '/home');
          } else {
            _speak();
          }
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < -_velocityThreshold) {
            _decrementCounter();
            _speak();
          } else if (details.primaryVelocity! > _velocityThreshold) {
            _incrementCounter();
            _speak();
          }
        },
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Scaffold(
                body: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                  const SizedBox(height: 40),
                  GestureDetector(
                      onDoubleTap: () {
                        _setCounter(0);
                        _speak();
                      },
                      child: appLogo(context, 90, 90)),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(0);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 0 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText[0],
                        style: textTheme(context).titleLarge!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 55),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(1);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 1 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText[1] + (AppSettings(context).getTextSize.toString()),
                        style: textTheme(context).labelMedium!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(2);
                            _speak();
                          },
                          onLongPress: () => AppSettings(context).setTextSize = 1,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 2
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText[2].split(" ")[2],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(3);
                            _speak();
                          },
                          onLongPress: () => AppSettings(context).setTextSize = 2,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 3
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText[3].split(" ")[2],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(4);
                            _speak();
                          },
                          onLongPress: () => AppSettings(context).setTextSize = 3,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 4
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText[4].split(" ")[2],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(5);
                            _speak();
                          },
                          onLongPress: () => AppSettings(context).setTextSize = 4,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 5
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText[5].split(" ")[2],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(6);
                            _speak();
                          },
                          onLongPress: () => AppSettings(context).setTextSize = 5,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 6
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText[6].split(" ")[2],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(height: 55),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(7);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 7 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText[7] +
                            (AppSettings(context).getTheme == 0
                                ? "Phone's theme"
                                : AppSettings(context).getTheme == 1
                                    ? "Light"
                                    : "Dark"),
                        style: textTheme(context).labelMedium!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(8);
                            _speak();
                          },
                          onLongPress: () {
                            _toggleTheme(ThemeMode.system);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 8
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText[8],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(9);
                            _speak();
                            AppSettings(context).setTheme = 1;
                          },
                          onLongPress: () {
                            AppSettings(context).setTheme = 1;
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 9
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText[9],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(10);
                            _speak();
                          },
                          onLongPress: () {
                            AppSettings(context).setTheme = 2;
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 10
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText[10],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                ])))));
  }
}
