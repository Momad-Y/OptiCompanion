import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

class WelcomePage1 extends StatefulWidget {
  const WelcomePage1({super.key});

  @override
  State<WelcomePage1> createState() => _WelcomePage1State();
}

class _WelcomePage1State extends State<WelcomePage1> {
  int _counter = 0;
  static const int _maxCounter = 3;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  ScrollController controller = ScrollController();

  FlutterTts? flutterTts;

  Tts? tts;

  final _pageTextEn = [
    "Welcome to Your Vision's Best Friend",
    "Swipe left or right anywhere on the screen to navigate between buttons or text.",
    "When an item is selected, it will be highlighted, fully shown on the screen, and read out aloud.",
    "Next page",
  ];

  final _pageTextAr = [
    "مرحبًا بك في أفضل صديق لرؤيتك",
    "اسحب يمينًا أو يسارًا في أي مكان على الشاشة للتنقل بين الأزرار أو النص",
    "عند تحديد عنصر ما، سيتم تحديده، وعرضه بالكامل على الشاشة، وقراءته بصوت عال",
    "الصفحة التالية",
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
          if (_counter == 3) {
            Navigator.pushNamed(context, '/welcome2');
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
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(0);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
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
                  const SizedBox(height: 55),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(1);
                      _speak();
                    },
                    child: Container(
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
                  const SizedBox(height: 20),
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(2);
                      _speak();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 4,
                            color: _counter == 2 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                      ),
                      child: Text(
                        _pageText![2],
                        style: textTheme(context).displayMedium!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 90),
                  _counter == 3
                      ? GestureDetector(
                          onDoubleTap: () {
                            _setCounter(3);
                            _speak();
                          },
                          child: selectedNextPageButton(context, '/welcome2'))
                      : GestureDetector(
                          onDoubleTap: () {
                            _setCounter(3);
                            _speak();
                          },
                          child: nextPageButton(context, '/welcome2')),
                ])))));
  }
}
