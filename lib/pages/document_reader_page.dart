import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

class DocumentReaderPage extends StatefulWidget {
  const DocumentReaderPage({super.key});

  @override
  State<DocumentReaderPage> createState() => _DocumentReaderPageState();
}

class _DocumentReaderPageState extends State<DocumentReaderPage> {
  int _counter = 0;
  static const int _maxCounter = 7;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  FlutterTts? flutterTts;
  Tts? tts;

  static const List<String> _pageTextEn = [
    "Document Reader",
    "Upload Document",
    "Upload Status: ",
    "Rewind 10 seconds",
    "Play/Pause",
    "Fast Forward 10 seconds",
    "Settings",
    "Home"
  ];

  static const _pageTextAr = [
    "قارئ المستندات",
    "تحميل المستند",
    "حالة التحميل: ",
    "إرجاع 10 ثوانٍ",
    "تشغيل/إيقاف مؤقت",
    "التقدم السريع 10 ثوانٍ",
    "الإعدادات",
    "الصفحة الرئيسية"
  ];

  List? _pageText = [];

  // String? _selectedLink;

  @override
  initState() {
    super.initState();
    tts = mainTts;
    _pageText = tts!.getLanguage == "English" ? _pageTextEn : _pageTextAr;
    flutterTts = tts!.initTts(flutterTts, false);
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
          _speak();
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
                    _counter == 1
                        ? GestureDetector(
                            onDoubleTap: () {
                              _setCounter(1);
                              _speak();
                            },
                            // onLongPress: () => _showLinkDialog(),
                            child: selectedHomeContainer(
                                context,
                                tts!.getLanguage() == "English"
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                            Icon(Icons.upload_file_rounded,
                                                size: 60, color: Theme.of(context).colorScheme.secondary),
                                            const SizedBox(height: 10),
                                            Text(_pageText![1],
                                                style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                            const SizedBox(height: 5),
                                          ])
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                            Icon(Icons.upload_file_rounded,
                                                size: 60, color: Theme.of(context).colorScheme.secondary),
                                            const SizedBox(height: 15),
                                            Text(_pageText![1],
                                                style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                            const SizedBox(height: 5),
                                          ])))
                        : GestureDetector(
                            onDoubleTap: () {
                              _setCounter(1);
                              _speak();
                            },
                            // onLongPress: () => _showLinkDialog(),
                            child: homeContainer(
                                context,
                                tts!.getLanguage() == "English"
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                            Icon(Icons.upload_file_rounded,
                                                size: 60, color: Theme.of(context).colorScheme.secondary),
                                            const SizedBox(height: 10),
                                            Text(_pageText![1],
                                                style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                            const SizedBox(height: 5),
                                          ])
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                            Icon(Icons.upload_file_rounded,
                                                size: 60, color: Theme.of(context).colorScheme.secondary),
                                            const SizedBox(height: 15),
                                            Text(_pageText![1],
                                                style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                            const SizedBox(height: 5),
                                          ])))
                  ]),
            )))));
  }
}
