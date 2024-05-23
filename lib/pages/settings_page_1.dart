import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

import '../settings.dart';

class SettingsPage1 extends StatefulWidget {
  const SettingsPage1({super.key});

  @override
  State<SettingsPage1> createState() => SettingsPage1State();
}

class SettingsPage1State extends State<SettingsPage1> {
  int _counter = 1;
  static const int _maxCounter = 15;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  ScrollController controller = ScrollController();

  FlutterTts? flutterTts;
  Tts? tts;

  AppSettings? appSettings;

  static const _pageTextEn = [
    "Adjust settings",
    "Select text size, current text size is ",
    "Text Size: 1",
    "Text Size: 2",
    "Text Size: 3",
    "Text Size: 4",
    "Text Size: 5",
    "Select theme, current theme is ",
    "Phone's Theme",
    "Light Theme",
    "Dark Theme",
    "Magnifier Settings, it is currently ",
    "Disable Magnifier",
    "Enable Magnifier",
    "Next page",
    "Home page",
  ];
  static const _pageTextAr = [
    "ضبط الإعدادات",
    "حدد حجم النص، الحجم الحالي هو ",
    "حجم النص: 1",
    "حجم النص: 2",
    "حجم النص: 3",
    "حجم النص: 4",
    "حجم النص: 5",
    "حدد السمة، السمة الحالية هي ",
    "سمة الهاتف",
    "سمة فاتحة",
    "سمة داكنة",
    "إعدادات المكبر، حاليًا ",
    "تعطيل المكبر",
    "تمكين المكبر",
    "الصفحة التالية",
    "الصفحة الرئيسية",
  ];

  List? _pageText = [];

  @override
  initState() {
    appSettings = mainAppSettings;
    appSettings!.initSettings();
    super.initState();
    tts = mainTts;
    tts!.initPrefs().then((_) => {
          flutterTts = tts!.initTts(false),
          _speak(),
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
      await flutterTts!.speak(_pageText![_counter] + (appSettings!.getTextSize().toString()));
    } else if (_counter == 7) {
      await flutterTts!.speak(_pageText![_counter] +
          (tts!.getLanguage() == "English"
              ? appSettings!.getTheme() == 0
                  ? "phone's theme"
                  : appSettings!.getTheme() == 1
                      ? "light"
                      : "dark"
              : appSettings!.getTheme() == 0
                  ? "سمة الهاتف"
                  : appSettings!.getTheme() == 1
                      ? "فاتحة"
                      : "داكنة"));
    } else if (_counter == 11) {
      await flutterTts!.speak(_pageText![_counter] +
          (tts!.getLanguage() == "English"
              ? (appSettings!.getIsMagnifierEnabled() == true ? "enabled" : "disabled")
              : (appSettings!.getIsMagnifierEnabled() == true ? "المكبر مفعل" : "المكبر غير مفعل")));
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
              appSettings!.setTextSize = 1;
            });
          } else if (_counter == 3) {
            setState(() {
              appSettings!.setTextSize = 2;
            });
          } else if (_counter == 4) {
            setState(() {
              appSettings!.setTextSize = 3;
            });
          } else if (_counter == 5) {
            setState(() {
              appSettings!.setTextSize = 4;
            });
          } else if (_counter == 6) {
            setState(() {
              appSettings!.setTextSize = 5;
            });
          } else if (_counter == 8) {
            setState(() {
              appSettings!.setTheme = 0;
            });
          } else if (_counter == 9) {
            setState(() {
              appSettings!.setTheme = 1;
            });
          } else if (_counter == 10) {
            setState(() {
              appSettings!.setTheme = 2;
            });
          } else if (_counter == 12) {
            setState(() {
              appSettings!.setIsMagnifierEnabled = false;
            });
          } else if (_counter == 13) {
            setState(() {
              appSettings!.setIsMagnifierEnabled = true;
            });
          } else if (_counter == 14) {
            Navigator.pushNamed(context, '/settings2');
          } else if (_counter == 15) {
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
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                        _pageText![1] + (appSettings!.getTextSize().toString()),
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
                            appSettings!.setTextSize = 1;
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
                            appSettings!.setTextSize = 2;
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
                            appSettings!.setTextSize = 3;
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
                            appSettings!.setTextSize = 4;
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
                            appSettings!.setTextSize = 5;
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
                                ? appSettings!.getTheme() == 0
                                    ? "phone's theme"
                                    : appSettings!.getTheme() == 1
                                        ? "light"
                                        : "dark"
                                : appSettings!.getTheme() == 0
                                    ? "سمة الهاتف"
                                    : appSettings!.getTheme() == 1
                                        ? "فاتحة"
                                        : "داكنة"),
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
                              appSettings!.setTheme = 0;
                            });
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
                              appSettings!.setTheme = 1;
                            });
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
                              _pageText![9],
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
                            setState(() {
                              appSettings!.setTheme = 2;
                            });
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
                              _pageText![10],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(11);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 11 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText![11] +
                            (tts!.getLanguage() == "English"
                                ? (appSettings!.getIsMagnifierEnabled() == true ? "enabled" : "disabled")
                                : (appSettings!.getIsMagnifierEnabled() == true ? "المكبر مفعل" : "المكبر غير مفعل")),
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
                            _setCounter(12);
                            _speak();
                          },
                          onLongPress: () {
                            setState(() {
                              appSettings!.setIsMagnifierEnabled = false;
                            });
                          },
                          child: Container(
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
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(13);
                            _speak();
                          },
                          onLongPress: () {
                            setState(() {
                              appSettings!.setIsMagnifierEnabled = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 4,
                                  color: _counter == 13
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.tertiary),
                            ),
                            child: Text(
                              _pageText![13],
                              style: textTheme(context).labelMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(height: 80),
                  _counter == 14
                      ? GestureDetector(
                          onDoubleTap: () {
                            _setCounter(14);
                            _speak();
                          },
                          child: selectedNextPageButton(context, '/settings2'))
                      : GestureDetector(
                          onDoubleTap: () {
                            _setCounter(14);
                            _speak();
                          },
                          child: nextPageButton(context, '/settings2')),
                  const SizedBox(height: 20),
                  _counter == 15
                      ? GestureDetector(
                          onDoubleTap: () {
                            _setCounter(15);
                            _speak();
                          },
                          child: selectedHomePageButton(context))
                      : GestureDetector(
                          onDoubleTap: () {
                            _setCounter(15);
                            _speak();
                          },
                          child: homePageButton(context)),
                ])))));
  }
}
