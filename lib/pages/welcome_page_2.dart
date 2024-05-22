import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

class WelcomePage2 extends StatefulWidget {
  const WelcomePage2({super.key});

  @override
  State<WelcomePage2> createState() => _WelcomePage2State();
}

class _WelcomePage2State extends State<WelcomePage2> {
  int _counter = 0;
  static const int _maxCounter = 3;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  ScrollController controller = ScrollController();

  FlutterTts? flutterTts;
  Tts? tts;

  static const _pageTextEn = [
    "Double tap on a button or piece of text to select it.",
    "To activate an item you have selected, long press on it or long press anywhere on the screen.",
    "Previous page",
    "Next page"
  ];

  static const _pageTextAr = [
    "اضغط مرتين على زر أو قطعة نص لتحديدها",
    "لتفعيل العنصر الذي قمت بتحديده، اضغط بشكل مطول عليه أو اضغط بشكل مطول في أي مكان على الشاشة",
    "الصفحة السابقة",
    "الصفحة التالية"
  ];

  List? _pageText = [];

  @override
  initState() {
    super.initState();
    tts = mainTts;
    flutterTts = tts!.initTts(flutterTts);
    _pageText = tts!.getLanguage == "English" ? _pageTextEn : _pageTextAr;
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
    await flutterTts!.speak(_pageText![_counter]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          if (_counter == 2) {
            Navigator.pushNamed(context, '/welcome1');
          } else if (_counter == 3) {
            Navigator.pushNamed(context, '/welcome_settings1');
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
                    child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    GestureDetector(
                        onDoubleTap: () {
                          _setCounter(0);
                          _speak();
                        },
                        child: appLogo(context, 180, 180)),
                    const SizedBox(height: 60),
                    GestureDetector(
                      onDoubleTap: () {
                        _setCounter(0);
                        _speak();
                      },
                      child: Container(
                        width: 350,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: _counter == 0 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                        ),
                        child: Text(
                          _pageText![0],
                          style: textTheme(context).displayMedium!,
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
                        width: 350,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: _counter == 1 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                        ),
                        child: Text(
                          _pageText![1],
                          style: textTheme(context).displayMedium!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    _counter == 2
                        ? GestureDetector(
                            onDoubleTap: () {
                              _setCounter(2);
                              _speak();
                            },
                            child: selectedPreviousPageButton(context, '/welcome1'))
                        : GestureDetector(
                            onDoubleTap: () {
                              _setCounter(2);
                              _speak();
                            },
                            child: previousPageButton(context, '/welcome1')),
                    const SizedBox(height: 20),
                    _counter == 3
                        ? GestureDetector(
                            onDoubleTap: () {
                              _setCounter(3);
                              _speak();
                            },
                            child: selectedNextPageButton(context, '/welcome_settings1'))
                        : GestureDetector(
                            onDoubleTap: () {
                              _setCounter(3);
                              _speak();
                            },
                            child: nextPageButton(context, '/welcome_settings1')),
                  ]),
            )))));
  }
}
