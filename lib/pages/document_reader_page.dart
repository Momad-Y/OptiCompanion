import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

import 'package:clipboard/clipboard.dart';

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

  final TextEditingController _urlController = TextEditingController();

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

  final List<String> _dialogTextEn = ["Select a PDF link", "Enter URL", "Paste", "Submit"];

  final List<String> _dialogTextAr = ["حدد رابط الملف", "أدخل الرابط", "الصق", "إرسال"];

  List? _dialogText = [];
  List? _pageText = [];

  // String? _selectedLink;

  @override
  initState() {
    super.initState();
    tts = mainTts;
    tts!.initPrefs().then((_) => {
          flutterTts = tts!.initTts(false),
          _speak(),
        });
    _dialogText = tts!.getLanguage() == "English" ? _dialogTextEn : _dialogTextAr;
    _pageText = tts!.getLanguage() == "English" ? _pageTextEn : _pageTextAr;
  }

  void _showLinkDialog() {
    _speakSpecific(_dialogText![0]);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(_dialogText![0], style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
            content: SizedBox(
              width: 100,
              height: 120,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _urlController,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.center,
                      style: textTheme(context).labelMedium,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 3),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          label: Center(
                              child: Text(_dialogText![1],
                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onLongPress: () {
                            FlutterClipboard.paste().then((value) {
                              setState(() {
                                _urlController.text = value;
                              });
                            });
                          },
                          onDoubleTap: () => _speakSpecific(_dialogText![2]),
                          child: Container(
                              width: 70,
                              height: 35,
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
                              ),
                              child: Text(_dialogText![2],
                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center))),
                      const SizedBox(width: 10),
                      GestureDetector(
                          onLongPress: () {},
                          onDoubleTap: () => _speakSpecific(_dialogText![3]),
                          child: Container(
                              width: 70,
                              height: 35,
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
                              ),
                              child: Text(_dialogText![3],
                                  style: textTheme(context).labelMedium!, textAlign: TextAlign.center))),
                    ],
                  )
                ],
              ),
            ),
          );
        });
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

  Future<void> _speakSpecific(String text) async {
    await flutterTts!.speak(text);
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
                            onLongPress: () => _showLinkDialog(),
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
                            onLongPress: () => _showLinkDialog(),
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
