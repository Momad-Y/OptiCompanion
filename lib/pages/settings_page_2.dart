import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

class SettingsPage2 extends StatefulWidget {
  const SettingsPage2({super.key});

  @override
  State<SettingsPage2> createState() => SettingsPage2State();
}

class SettingsPage2State extends State<SettingsPage2> {
  int _counter = 1;
  static const int _maxCounter = 14;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  ScrollController controller = ScrollController();

  FlutterTts? flutterTts;
  Tts? tts;

  static const _pageTextEn = [
    "Adjust Audio Settings",
    "Select audio speed, current audio speed is ",
    "Audio Speed: 1",
    "Audio Speed: 2",
    "Audio Speed: 3",
    "Audio Speed: 4",
    "Audio Speed: 5",
    "Select voice gender, current voice gender is ",
    "Male",
    "Female",
    "App Language, current speech language is ",
    "English",
    "Arabic",
    "Previous page",
    "Home page",
  ];

  static const _pageTextAr = [
    "ضبط إعدادات الصوت",
    "حدد سرعة الصوت، السرعة الصوتية الحالية هي ",
    "سرعة الصوت: 1",
    "سرعة الصوت: 2",
    "سرعة الصوت: 3",
    "سرعة الصوت: 4",
    "سرعة الصوت: 5",
    "حدد جنس الصوت، الجنس الصوتي الحالي هو ",
    "ذكر",
    "أنثى",
    "لغة التطبيق، اللغة الحالية هي ",
    "الإنجليزية",
    "العربية",
    "الصفحة السابقة",
    "الصفحة الرئيسية",
  ];

  List? _pageText = [];

  @override
  initState() {
    super.initState();
    tts = mainTts;
    tts!.initPrefs().then((_) {
      flutterTts = tts!.initTts(false);
      _speak();
    });
    _pageText = tts!.getLanguage() == "English" ? _pageTextEn : _pageTextAr;
    WidgetsBinding.instance.addPostFrameCallback((_) => _decrementCounter());
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
      await flutterTts!.speak(_pageText![_counter] + tts!.getSpeed().toString());
    } else if (_counter == 7) {
      await flutterTts!.speak(_pageText![_counter] +
          (tts!.getLanguage() == "English"
              ? tts!.getGender() == "Male"
                  ? "male"
                  : "female"
              : tts!.getGender() == "Male"
                  ? "ذكر"
                  : "أنثى"));
    } else if (_counter == 10) {
      await flutterTts!.speak(_pageText![_counter] + (tts!.getLanguage() == "English" ? "English" : "العربية"));
    } else {
      await flutterTts!.speak(_pageText![_counter]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          if (_counter == 2) {
            setState(() {
              tts!.setTtsSpeed(1);
            });
          } else if (_counter == 3) {
            setState(() {
              tts!.setTtsSpeed(2);
            });
          } else if (_counter == 4) {
            setState(() {
              tts!.setTtsSpeed(3);
            });
          } else if (_counter == 5) {
            setState(() {
              tts!.setTtsSpeed(4);
            });
          } else if (_counter == 6) {
            setState(() {
              tts!.setTtsSpeed(5);
            });
          } else if (_counter == 8) {
            setState(() {
              tts!.setTtsGender("Male");
            });
          } else if (_counter == 9) {
            setState(() {
              tts!.setTtsGender("Female");
            });
          } else if (_counter == 11) {
            if (tts!.getLanguage() == "English") {
              return;
            }
            setState(() {
              tts!.setTtsLanguage("English");
            });
            Navigator.pushNamed(context, '/home');
          } else if (_counter == 12) {
            if (tts!.getLanguage() == "Arabic") {
              return;
            }
            setState(() {
              tts!.setTtsLanguage("Arabic");
            });
            Navigator.pushNamed(context, '/home');
          } else if (_counter == 13) {
            Navigator.pushNamed(context, '/settings1');
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
                      width: 300,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 0 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText![0],
                        style: textTheme(context).titleLarge!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(1);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 1 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText![1] + tts!.getSpeed().toString(),
                        style: textTheme(context).displaySmall!,
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
                          onLongPress: () => setState(() {
                            tts!.setTtsSpeed(1);
                          }),
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
                              _pageText![2].split(" ")[2],
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
                          onLongPress: () => setState(() {
                            tts!.setTtsSpeed(2);
                          }),
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
                              _pageText![3].split(" ")[2],
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
                          onLongPress: () => setState(() {
                            tts!.setTtsSpeed(3);
                          }),
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
                              _pageText![4].split(" ")[2],
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
                          onLongPress: () => setState(() {
                            tts!.setTtsSpeed(4);
                          }),
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
                              _pageText![5].split(" ")[2],
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
                          onLongPress: () => setState(() {
                            tts!.setTtsSpeed(5);
                          }),
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
                              _pageText![6].split(" ")[2],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(7);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 7 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText![7] +
                            (tts!.getLanguage() == "English"
                                ? tts!.getGender() == "Male"
                                    ? "male"
                                    : "female"
                                : tts!.getGender() == "Male"
                                    ? "ذكر"
                                    : "أنثى"),
                        style: textTheme(context).displaySmall!,
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
                            setState(() {
                              tts!.setTtsGender("Male");
                            });
                          },
                          child: Container(
                            width: 100,
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
                              _pageText![8],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(9);
                            _speak();
                          },
                          onLongPress: () {
                            setState(() {
                              tts!.setTtsGender("Female");
                            });
                          },
                          child: Container(
                            width: 100,
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
                              _pageText![9],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(10);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 10 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText![10] + (tts!.getLanguage() == "English" ? "English" : "العربية"),
                        style: textTheme(context).displaySmall!,
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
                            _setCounter(11);
                            _speak();
                          },
                          onLongPress: () {
                            if (tts!.getLanguage() == "English") {
                              return;
                            }
                            setState(() {
                              tts!.setTtsLanguage("English");
                            });
                            Navigator.pushNamed(context, '/home');
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 11
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText![11],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(12);
                            _speak();
                          },
                          onLongPress: () {
                            if (tts!.getLanguage() == "Arabic") {
                              return;
                            }
                            setState(() {
                              tts!.setTtsLanguage("Arabic");
                            });
                            Navigator.pushNamed(context, '/home');
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 12
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText![12],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(height: 60),
                  _counter == 13
                      ? GestureDetector(
                          onDoubleTap: () {
                            _setCounter(13);
                            _speak();
                          },
                          child: selectedPreviousPageButton(context, '/settings1'))
                      : GestureDetector(
                          onDoubleTap: () {
                            _setCounter(13);
                            _speak();
                          },
                          child: previousPageButton(context, '/settings1')),
                  const SizedBox(height: 20),
                  _counter == 14
                      ? GestureDetector(
                          onDoubleTap: () {
                            _setCounter(14);
                            _speak();
                          },
                          child: selectedHomePageButton(context))
                      : GestureDetector(
                          onDoubleTap: () {
                            _setCounter(14);
                            _speak();
                          },
                          child: homePageButton(context)),
                ])))));
  }
}
