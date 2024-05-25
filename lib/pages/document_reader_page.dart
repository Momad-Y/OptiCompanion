import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class DocumentReaderPage extends StatefulWidget {
  const DocumentReaderPage({super.key});

  @override
  State<DocumentReaderPage> createState() => _DocumentReaderPageState();
}

class _DocumentReaderPageState extends State<DocumentReaderPage> {
  int _counter = 0;
  static const int _maxCounter = 5;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  FlutterTts? flutterTts;
  Tts? tts;

  late String _uploadStatus;
  late String _documentPath;
  late PdfDocument document;

  late List<String> contentList = [];
  int _contentIndex = 0;

  bool _isPlaying = false;

  final List<String> _pageTextEn = ["Document Reader", "Upload Document", "", "Settings", "Play", "Home"];

  final List<String> _pageTextAr = ["قارئ المستندات", "تحميل المستند", "", "الإعدادات", "تشغيل", "الصفحة الرئيسية"];

  List? _pageText = [];

  @override
  initState() {
    super.initState();
    tts = mainTts;
    flutterTts = tts!.initTts(flutterTts, true);
    _uploadStatus =
        tts!.getLanguage == "English" ? "Upload Status: No file uploaded" : "حالة التحميل: لم يتم تحميل أي ملف";
    _pageText = tts!.getLanguage == "English" ? _pageTextEn : _pageTextAr;
    _pageText![2] = _uploadStatus;
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

  void _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) {
      _uploadStatus = tts!.getLanguage == "English" ? "No file uploaded" : "لم يتم تحميل أي ملف";

      return;
    }

    // If file is not a PDF
    if (result.files.first.extension!.toLowerCase() != "pdf") {
      _uploadStatus = tts!.getLanguage == "English"
          ? "Upload Status: File type not supported"
          : "حالة التحميل: نوع الملف غير مدعوم";
      setState(() {
        _pageText![2] = _uploadStatus;
        _setCounter(2);
        _speak();
      });
      return;
    }

    _uploadStatus = tts!.getLanguage == "English"
        ? "Upload Status: File uploaded successfully"
        : "حالة التحميل: تم تحميل الملف بنجاح";
    setState(() {
      _pageText![2] = _uploadStatus;
      _setCounter(2);
      _speak();
      _documentPath = result.files.first.path!;
    });
    _parseDocument();
  }

  Future<void> _parseDocument() async {
    document = PdfDocument(inputBytes: await File(_documentPath).readAsBytes());
    String content = PdfTextExtractor(document).extractText();
    document.dispose();
    _cleanContent(content);
  }

  void _cleanContent(String content) {
    // Split content into a list of sentences by splitting at periods, question marks, and exclamation points
    contentList = content.split(RegExp(r"[.?!]"));

    for (int i = 0; i < contentList.length; i++) {
      // Remove all leading and trailing whitespace
      contentList[i] = contentList[i].trim();

      // Remove all newlines
      contentList[i] = contentList[i].replaceAll(RegExp(r"\n+"), " ");

      // Replace all slashes, backslashes, underscores, hyphens, and colons with spaces
      contentList[i] = contentList[i].replaceAll(RegExp(r"[/\\_:-]"), " ");

      // Remove all special characters
      String specialCharacters = "!@#%^&*()_+{}|:<>?`-=[]\\;',./~\"";
      for (int i = 0; i < specialCharacters.length; i++) {
        contentList[i] = contentList[i].replaceAll(specialCharacters[i], " ");
      }

      // Remove all extra spaces and tabs
      contentList[i] = contentList[i].replaceAll(RegExp(r"\s+"), " ");
      contentList[i] = contentList[i].replaceAll(RegExp(r"\t+"), " ");

      // Remove all leading and trailing whitespace
      contentList[i] = contentList[i].trim();
    }

    // Remove all sentences that are empty or contain only whitespace
    contentList.removeWhere((sentence) => sentence.trim().isEmpty);
  }

  Future<void> _togglePlaying() async {
    if (contentList.isEmpty) {
      tts!.getLanguage == "English"
          ? await _speakSelected("No document uploaded")
          : await _speakSelected("لم يتم تحميل أي مستند");
      return;
    }

    if (_isPlaying) {
      _pageText![4] = tts!.getLanguage == "English" ? "Play" : "تشغيل";
      await _stop()
          .then((_) => tts!.getLanguage == "English" ? _speakSelected("Paused") : _speakSelected("تم الإيقاف"));
    } else {
      _pageText![4] = tts!.getLanguage == "English" ? "Pause" : "إيقاف مؤقت";
      await tts!.getLanguage == "English"
          ? _speakSelected("Playing").then((_) => _speakContent())
          : _speakSelected("جاري التشغيل").then((_) => _speakContent());
    }
  }

  Future<void> _speakContent() async {
    setState(() {
      _isPlaying = true;
    });
    for (int i = _contentIndex; i < contentList.length; i++) {
      await flutterTts!.speak(contentList[i]).then((value) => {
            if (value == 1)
              {
                _contentIndex = i,
                if (_contentIndex == contentList.length - 1) {_contentIndex = 0},
              }
          });
      if (!_isPlaying) {
        _contentIndex++;
        break;
      }
    }
  }

  Future<void> _speakSelected(String text) async {
    await flutterTts!.speak(text);
  }

  Future _stop() async {
    await flutterTts!.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          if (_counter == 1) {
            _pickDocument();
          } else if (_counter == 3) {
            _stop().then((value) => Navigator.pushNamed(context, '/settings1'));
          } else if (_counter == 4) {
            _togglePlaying();
          } else if (_counter == 5) {
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
                            onLongPress: () => _pickDocument(),
                            child: selectedHomeContainer(
                                context,
                                tts!.getLanguage == "English"
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
                            onLongPress: () => _pickDocument(),
                            child: homeContainer(
                                context,
                                tts!.getLanguage == "English"
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
                                          ]))),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onDoubleTap: () {
                        _setCounter(2);
                        _speak();
                      },
                      child: Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: _counter == 2 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                        ),
                        child: Text(
                          _pageText![2],
                          style: textTheme(context).labelLarge!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(3);
                            _speak();
                          },
                          onLongPress: () {
                            _stop().then((value) => Navigator.pushNamed(context, '/settings1'));
                          },
                          child: Icon(Icons.settings_applications_rounded,
                              size: 50, color: Theme.of(context).colorScheme.secondary),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(4);
                            _speak();
                          },
                          onLongPress: () {
                            _togglePlaying();
                          },
                          child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                              size: 60, color: Theme.of(context).colorScheme.secondary),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            _setCounter(5);
                            _speak();
                          },
                          onLongPress: () {
                            _stop().then((value) => Navigator.pushNamed(context, '/home'));
                          },
                          child: Icon(Icons.home_rounded, size: 50, color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ]),
            )))));
  }
}
