import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  int _counter = 0;
  static const int _maxCounter = 5;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  ScrollController controller = ScrollController();

  FlutterTts? flutterTts;
  Tts? tts;

  static const _pageTextEn = [
    "Help Page",
    "Swipe left or right anywhere on the screen to navigate between buttons or text.",
    "When an item is selected, it will be highlighted, fully shown on the screen, and read out aloud.",
    "Double tap on a button or piece of text to select it.",
    "To activate an item you have selected, long press on it or long press anywhere on the screen.",
    "Home page",
  ];
  static const _pageTextAr = [
    "صفحة المساعدة",
    "اسحب يمينًا أو يسارًا في أي مكان على الشاشة للتنقل بين الأزرار أو النص",
    "عند تحديد عنصر ما، سيتم تحديده، وعرضه بالكامل على الشاشة، وقراءته بصوت عال",
    "اضغط مرتين على زر أو قطعة نص لتحديدها",
    "لتفعيل العنصر الذي قمت بتحديده، اضغط بشكل مطول عليه أو اضغط بشكل مطول في أي مكان على الشاشة",
    "الصفحة الرئيسية",
  ];

  List? _pageText = [];

  @override
  initState() {
    super.initState();
    tts = mainTts;
    tts!.initPrefs().then((_) => {flutterTts = tts!.initTts(false), _speak()});
    _pageText = tts!.getLanguage() == "English" ? _pageTextEn : _pageTextAr;
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
          if (_counter == 5) {
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
                    child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 55),
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
                        width: 350,
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
                    tts!.getLanguage() == "English" ? const SizedBox(height: 45) : const SizedBox(height: 55),
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
                    tts!.getLanguage() == "English" ? const SizedBox(height: 10) : const SizedBox(height: 20),
                    GestureDetector(
                      onDoubleTap: () {
                        _setCounter(2);
                        _speak();
                      },
                      child: Container(
                        width: 350,
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
                    tts!.getLanguage() == "English" ? const SizedBox(height: 10) : const SizedBox(height: 20),
                    GestureDetector(
                      onDoubleTap: () {
                        _setCounter(3);
                        _speak();
                      },
                      child: Container(
                        width: 350,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: _counter == 3 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                        ),
                        child: Text(
                          _pageText![3],
                          style: textTheme(context).displayMedium!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    tts!.getLanguage() == "English" ? const SizedBox(height: 10) : const SizedBox(height: 20),
                    GestureDetector(
                      onDoubleTap: () {
                        _setCounter(4);
                        _speak();
                      },
                      child: Container(
                        width: 350,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: _counter == 4 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                        ),
                        child: Text(
                          _pageText![4],
                          style: textTheme(context).displayMedium!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    tts!.getLanguage() == "English" ? const SizedBox(height: 60) : const SizedBox(height: 80),
                    _counter == 5
                        ? GestureDetector(
                            onDoubleTap: () {
                              _setCounter(5);
                              _speak();
                            },
                            child: selectedHomePageButton(context))
                        : GestureDetector(
                            onDoubleTap: () {
                              _setCounter(5);
                              _speak();
                            },
                            child: homePageButton(context)),
                  ]),
            )))));
  }
}
