import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  static const int _maxCounter = 8;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  ScrollController controller = ScrollController();

  FlutterTts? flutterTts;

  static const List<String> _homeScreen = [
    "Home Screen",
    "Optical Character Recognition",
    "Object Recognition",
    "Document Reader",
    "Feedback",
    "Settings",
    "Help",
    "Get in Touch with Me",
    "History"
  ];

  @override
  initState() {
    super.initState();
    flutterTts = Tts().initTts(flutterTts);
    _speak();
  }

  void _scrollPage() {
    if (_counter == 7 || _counter == 8) {
      // Scroll to the bottom of the page
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }

    if (_counter == 0 || _counter == 1 || _counter == 2) {
      // Scroll to the top of the page
      controller.animateTo(
        controller.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
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
    await flutterTts!.speak(_homeScreen[_counter]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < -_velocityThreshold) {
          _decrementCounter();
          _scrollPage();
          _speak();
        } else if (details.primaryVelocity! > _velocityThreshold) {
          _incrementCounter();
          _scrollPage();
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
                      _scrollPage();
                      _speak();
                    },
                    child: appLogo(context)),
                GestureDetector(
                  onDoubleTap: () {
                    _setCounter(0);
                    _scrollPage();
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
                      _homeScreen[0],
                      style: textTheme(context).titleLarge!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 55),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 1
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(1);
                                      _scrollPage();
                                      _speak();
                                    },
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomPaint(
                                                  foregroundPainter: BorderPainter(context),
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
                                                      width: 65,
                                                      height: 65,
                                                      child: Text("A", style: textTheme(context).displayLarge!))),
                                              const SizedBox(height: 19),
                                              Text("OCR", style: textTheme(context).labelLarge!),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(1);
                                      _scrollPage();
                                      _speak();
                                    },
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomPaint(
                                                  foregroundPainter: BorderPainter(context),
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
                                                      width: 65,
                                                      height: 65,
                                                      child: Text("A", style: textTheme(context).displayLarge!))),
                                              const SizedBox(height: 19),
                                              Text("OCR", style: textTheme(context).labelLarge!),
                                            ]))),
                            const SizedBox(width: 45),
                            _counter == 2
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(2);
                                      _scrollPage();
                                      _speak();
                                    },
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomPaint(
                                                  foregroundPainter: BorderPainter(context),
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
                                                      width: 65,
                                                      height: 65,
                                                      child: Icon(Icons.pedal_bike,
                                                          size: 40, color: Theme.of(context).colorScheme.secondary))),
                                              const SizedBox(height: 10),
                                              Text(_homeScreen[2],
                                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                            ])))
                                : homeContainer(
                                    context,
                                    GestureDetector(
                                        onDoubleTap: () {
                                          _setCounter(2);
                                          _scrollPage();
                                          _speak();
                                        },
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomPaint(
                                                  foregroundPainter: BorderPainter(context),
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
                                                      width: 65,
                                                      height: 65,
                                                      child: Icon(Icons.pedal_bike,
                                                          size: 40, color: Theme.of(context).colorScheme.secondary))),
                                              const SizedBox(height: 10),
                                              Text(_homeScreen[2],
                                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                            ]))),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 3
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(3);
                                      _speak();
                                    },
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.file_open_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 10),
                                              Text(_homeScreen[3],
                                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                              const SizedBox(height: 5),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(3);
                                      _speak();
                                    },
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.file_open_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 10),
                                              Text(_homeScreen[3],
                                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                              const SizedBox(height: 5),
                                            ]))),
                            const SizedBox(width: 45),
                            _counter == 4
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(4);
                                      _speak();
                                    },
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.thumbs_up_down_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_homeScreen[4],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(4);
                                      _speak();
                                    },
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.thumbs_up_down_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_homeScreen[4],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ]))),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 5
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(5);
                                      _speak();
                                    },
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.settings_applications_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_homeScreen[5],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(5);
                                      _speak();
                                    },
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.settings_applications_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_homeScreen[5],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ]))),
                            const SizedBox(width: 45),
                            _counter == 6
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(6);
                                      _speak();
                                    },
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.help_outline_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_homeScreen[6],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(6);
                                      _speak();
                                    },
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.help_outline_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_homeScreen[6],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ]))),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 7
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(7);
                                      _scrollPage();
                                      _speak();
                                    },
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.mail_outline_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 10),
                                              Text(_homeScreen[7],
                                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                              const SizedBox(height: 5),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(7);
                                      _scrollPage();
                                      _speak();
                                    },
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.mail_outline_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 10),
                                              Text(_homeScreen[7],
                                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                              const SizedBox(height: 5),
                                            ]))),
                            const SizedBox(width: 45),
                            _counter == 8
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(8);
                                      _scrollPage();
                                      _speak();
                                    },
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.history_toggle_off_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_homeScreen[8],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(8);
                                      _scrollPage();
                                      _speak();
                                    },
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.history_toggle_off_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_homeScreen[8],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ]))),
                          ],
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
