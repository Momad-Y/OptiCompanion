import 'dart:async';

import 'package:flutter/material.dart';

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

  Tts? tts;

  static const List<String> _pageTextEn = [
    "Home Page",
    "Optical Character Recognition",
    "Object Recognition",
    "Document Reader",
    "Feedback",
    "Settings",
    "Help",
    "Get in Touch with Me",
    "History"
  ];

  static const List<String> _pageTextAr = [
    "الصفحة الرئيسية",
    "التعرف الضوئي على النصوص",
    "التعرف على الأشياء",
    "قارئ المستندات",
    "الإنطباعات",
    "الإعدادات",
    "المساعدة",
    "تواصل معي",
    "السجل"
  ];

  List? _pageText = [];

  @override
  initState() {
    super.initState();
    tts = mainTts;
    flutterTts = tts!.initTts(flutterTts, false);
    _pageText = tts!.getLanguage == "English" ? _pageTextEn : _pageTextAr;
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
    await flutterTts!.speak(_pageText![_counter]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /*
        TODO: Add History Page
        TODO: Complete Document Reader
        TODO: Add Feedback Page
      */
      onLongPress: () {
        if (_counter == 0) {
          Navigator.pushNamed(context, '/welcome1'); // TODO: Debug
        } else if (_counter == 1) {
          // Navigator.pushNamed(context, '/ocr'); // TODO: Add OCR Page
        } else if (_counter == 2) {
          Navigator.pushNamed(context, '/object_recognition');
        } else if (_counter == 3) {
          Navigator.pushNamed(context, '/document_reader');
        } else if (_counter == 5) {
          Navigator.pushNamed(context, '/settings1');
        } else if (_counter == 6) {
          Navigator.pushNamed(context, '/help');
        } else if (_counter == 7) {
          Navigator.pushNamed(context, '/get_in_touch');
        } else {
          _speak();
        }
      },
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
                    child: appLogo(context, 90, 90)),
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
                      _pageText![0],
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
                                    // onLongPress: () => Navigator.pushNamed(context, '/ocr'),
                                    child: selectedHomeContainer(
                                        context,
                                        tts!.getLanguage() == "English"
                                            ? Column(
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
                                                  ])
                                            : Column(
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
                                                    const SizedBox(height: 10),
                                                    Text("التعرف الضوئي على النصوص",
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                  ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(1);
                                      _scrollPage();
                                      _speak();
                                    },
                                    // onLongPress: () => Navigator.pushNamed(context, '/ocr'),
                                    child: homeContainer(
                                        context,
                                        tts!.getLanguage() == "English"
                                            ? Column(
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
                                                  ])
                                            : Column(
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
                                                    const SizedBox(height: 10),
                                                    Text("التعرف الضوئي على النصوص",
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                  ]))),
                            const SizedBox(width: 45),
                            _counter == 2
                                ? GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(2);
                                      _scrollPage();
                                      _speak();
                                    },
                                    onLongPress: () => Navigator.pushNamed(context, '/object_recognition'),
                                    child: selectedHomeContainer(
                                        context,
                                        tts!.getLanguage() == "English"
                                            ? Column(
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
                                                                size: 40,
                                                                color: Theme.of(context).colorScheme.secondary))),
                                                    const SizedBox(height: 10),
                                                    Text(_pageText![2],
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                  ])
                                            : Column(
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
                                                                size: 40,
                                                                color: Theme.of(context).colorScheme.secondary))),
                                                    const SizedBox(height: 20),
                                                    Text(_pageText![2],
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 10),
                                                  ])))
                                : homeContainer(
                                    context,
                                    GestureDetector(
                                        onDoubleTap: () {
                                          _setCounter(2);
                                          _scrollPage();
                                          _speak();
                                        },
                                        onLongPress: () => Navigator.pushNamed(context, '/object_recognition'),
                                        child: tts!.getLanguage() == "English"
                                            ? Column(
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
                                                                size: 40,
                                                                color: Theme.of(context).colorScheme.secondary))),
                                                    const SizedBox(height: 10),
                                                    Text(_pageText![2],
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                  ])
                                            : Column(
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
                                                                size: 40,
                                                                color: Theme.of(context).colorScheme.secondary))),
                                                    const SizedBox(height: 20),
                                                    Text(_pageText![2],
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 10),
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
                                    onLongPress: () => Navigator.pushNamed(context, '/document_reader'),
                                    child: selectedHomeContainer(
                                        context,
                                        tts!.getLanguage() == "English"
                                            ? Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.file_open_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 10),
                                                    Text(_pageText![3],
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 5),
                                                  ])
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.file_open_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 13),
                                                    Text(_pageText![3],
                                                        style: textTheme(context).labelLarge!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 5),
                                                  ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(3);
                                      _speak();
                                    },
                                    onLongPress: () => Navigator.pushNamed(context, '/document_reader'),
                                    child: homeContainer(
                                        context,
                                        tts!.getLanguage() == "English"
                                            ? Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.file_open_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 10),
                                                    Text(_pageText![3],
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 5),
                                                  ])
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.file_open_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 13),
                                                    Text(_pageText![3],
                                                        style: textTheme(context).labelLarge!,
                                                        textAlign: TextAlign.center),
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
                                        tts!.getLanguage() == "English"
                                            ? Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.thumbs_up_down_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 12),
                                                    Text(_pageText![4],
                                                        style: textTheme(context).labelLarge!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 8),
                                                  ])
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.thumbs_up_down_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 12),
                                                    Text(_pageText![4],
                                                        style: textTheme(context).labelLarge!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 5),
                                                  ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(4);
                                      _speak();
                                    },
                                    child: homeContainer(
                                        context,
                                        tts!.getLanguage() == "English"
                                            ? Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.thumbs_up_down_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 12),
                                                    Text(_pageText![4],
                                                        style: textTheme(context).labelLarge!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 8),
                                                  ])
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.thumbs_up_down_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 12),
                                                    Text(_pageText![4],
                                                        style: textTheme(context).labelLarge!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 5),
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
                                    onLongPress: () => Navigator.pushNamed(context, '/settings1'),
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.settings_applications_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_pageText![5],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(5);
                                      _speak();
                                    },
                                    onLongPress: () => Navigator.pushNamed(context, '/settings1'),
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.settings_applications_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_pageText![5],
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
                                    onLongPress: () => Navigator.pushNamed(context, '/help'),
                                    child: selectedHomeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.help_outline_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_pageText![6],
                                                  style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                              const SizedBox(height: 8),
                                            ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(6);
                                      _speak();
                                    },
                                    onLongPress: () => Navigator.pushNamed(context, '/help'),
                                    child: homeContainer(
                                        context,
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.help_outline_rounded,
                                                  size: 60, color: Theme.of(context).colorScheme.secondary),
                                              const SizedBox(height: 12),
                                              Text(_pageText![6],
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
                                    onLongPress: () => Navigator.pushNamed(context, '/get_in_touch'),
                                    child: selectedHomeContainer(
                                        context,
                                        tts!.getLanguage() == "English"
                                            ? Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.mail_outline_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 10),
                                                    Text(_pageText![7],
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 5),
                                                  ])
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.mail_outline_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 12),
                                                    Text(_pageText![7],
                                                        style: textTheme(context).labelLarge!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 7),
                                                  ])))
                                : GestureDetector(
                                    onDoubleTap: () {
                                      _setCounter(7);
                                      _scrollPage();
                                      _speak();
                                    },
                                    onLongPress: () => Navigator.pushNamed(context, '/get_in_touch'),
                                    child: homeContainer(
                                        context,
                                        tts!.getLanguage() == "English"
                                            ? Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.mail_outline_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 10),
                                                    Text(_pageText![7],
                                                        style: textTheme(context).labelMedium!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 5),
                                                  ])
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Icon(Icons.mail_outline_rounded,
                                                        size: 60, color: Theme.of(context).colorScheme.secondary),
                                                    const SizedBox(height: 12),
                                                    Text(_pageText![7],
                                                        style: textTheme(context).labelLarge!,
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 7),
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
                                              Text(_pageText![8],
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
                                              Text(_pageText![8],
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
