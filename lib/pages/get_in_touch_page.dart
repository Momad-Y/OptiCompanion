import 'dart:async';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';
import '../widgets.dart';

class GetInTouchPage extends StatefulWidget {
  const GetInTouchPage({super.key});

  @override
  State<GetInTouchPage> createState() => _GetInTouchPageState();
}

class _GetInTouchPageState extends State<GetInTouchPage> {
  int _counter = 0;
  static const int _maxCounter = 4;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  FlutterTts? flutterTts;
  Tts? tts;

  static const List<String> _pageTextEn = ["Get in Touch With Me", "Email", "LinkedIn", "GitHub", "Home Page"];
  static const List<String> _pageTextAr = ["تواصل معي", "البريد الإلكتروني", "لينكد إن", "جيت هاب", "الصفحة الرئيسية"];

  List? _pageText = [];

  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'Mohamed.y.abdelnasser@gmail.com',
  );

  final Uri _linkedinLaunchUri = Uri(
    scheme: 'https',
    path: 'www.linkedin.com/in/Mohamed-y-Abdelnasser',
  );

  final Uri _githubLaunchUri = Uri(
    scheme: 'https',
    path: 'github.com/Momad-Y',
  );

  Future<void> _launchURL(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

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
          if (_counter == 1) {
            _launchURL(_emailLaunchUri);
          } else if (_counter == 2) {
            _launchURL(_linkedinLaunchUri);
          } else if (_counter == 3) {
            _launchURL(_githubLaunchUri);
          } else if (_counter == 4) {
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
                        width: tts!.getLanguage == "English" ? 280 : 190,
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
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
                    const SizedBox(height: 110),
                    GestureDetector(
                      onDoubleTap: () {
                        _setCounter(1);
                        _speak();
                      },
                      onLongPress: () {
                        _launchURL(_emailLaunchUri);
                      },
                      child: Container(
                        width: 250,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: _counter == 1
                                  ? Theme.of(context).colorScheme.outline
                                  : Theme.of(context).colorScheme.tertiary),
                        ),
                        child: ListTile(
                          title: Text(
                            _pageText![1],
                            style: textTheme(context).labelLarge!,
                            textAlign: TextAlign.center,
                          ),
                          trailing: Icon(Icons.email_rounded, size: 35, color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                    GestureDetector(
                      onDoubleTap: () {
                        _setCounter(2);
                        _speak();
                      },
                      onLongPress: () {
                        _launchURL(_linkedinLaunchUri);
                      },
                      child: Container(
                        width: 250,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: _counter == 2
                                  ? Theme.of(context).colorScheme.outline
                                  : Theme.of(context).colorScheme.tertiary),
                        ),
                        child: ListTile(
                          title: Text(
                            _pageText![2],
                            style: textTheme(context).labelLarge!,
                            textAlign: TextAlign.center,
                          ),
                          trailing:
                              Icon(Icons.person_rounded, size: 35, color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                    GestureDetector(
                      onDoubleTap: () {
                        _setCounter(3);
                        _speak();
                      },
                      onLongPress: () {
                        _launchURL(_githubLaunchUri);
                      },
                      child: Container(
                        width: 250,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: _counter == 3
                                  ? Theme.of(context).colorScheme.outline
                                  : Theme.of(context).colorScheme.tertiary),
                        ),
                        child: ListTile(
                          title: Text(
                            _pageText![3],
                            style: textTheme(context).labelLarge!,
                            textAlign: TextAlign.center,
                          ),
                          trailing: Icon(Icons.code_rounded, size: 35, color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 120),
                    _counter == 4
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
                  ]),
            )))));
  }
}
