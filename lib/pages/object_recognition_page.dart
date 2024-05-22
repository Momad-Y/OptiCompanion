import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';

import '../camera.dart';

import 'package:camera/camera.dart';

class ObjectRecognitionPage extends StatefulWidget {
  const ObjectRecognitionPage({super.key});

  @override
  State<ObjectRecognitionPage> createState() => _ObjectRecognitionPageState();
}

class _ObjectRecognitionPageState extends State<ObjectRecognitionPage> {
  int _counter = 1;
  static const int _maxCounter = 4;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  ScrollController controller = ScrollController();

  FlutterTts? flutterTts;
  Tts? tts;

  late CameraController cameraController;
  late AppCamera appCamera;

  bool _isCameraInitialized = false;
  bool _isFlashOn = false;
  bool _isPaused = false;
  bool _isCameraError = false;
  bool _isAccessDenied = false;

  final List<String> _pageTextEn = [
    "Previous page",
    "Object Recognition Page",
    "Turn on flashlight",
    "Result",
    "Pause the Camera",
  ];

  final List<String> _pageTextAr = [
    "الصفحة السابقة",
    "صفحة التعرف على الأشياء",
    "تشغيل الفلاش",
    "النتيجة",
    "إيقاف الكاميرا",
  ];

  static const _errorTextEn = [
    "Camera access denied",
    "Camera error",
  ];

  static const _errorTextAr = [
    "تم رفض الوصول إلى الكاميرا",
    "خطأ في الكاميرا",
  ];

  List? _pageText = [];

  List? _errorText = [];

  @override
  initState() {
    super.initState();
    appCamera = mainAppCamera;
    _initializeCamera();
    tts = mainTts;
    flutterTts = tts!.initTts(flutterTts);
    _pageText = tts!.getLanguage == "English" ? _pageTextEn : _pageTextAr;
    _errorText = tts!.getLanguage == "English" ? _errorTextEn : _errorTextAr;
    _speak();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
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

  void _initializeCamera() {
    cameraController = CameraController(appCamera.cameras[0], ResolutionPreset.ultraHigh);
    cameraController.initialize().then((_) {
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
        _isAccessDenied = false;
        _isCameraError = false;
      });
    }).catchError((error) {
      if (error is CameraException) {
        switch (error.code) {
          case 'CameraAccessDenied':
            setState(() {
              _isAccessDenied = true;
              _speakSelected(_errorText![0]);
            });
            break;
          default:
            setState(() {
              _isCameraError = true;
              _speakSelected(_errorText![1]);
            });
            break;
        }
      }
    });
  }

  void _toggleFlash() {
    if (_isCameraInitialized && !_isAccessDenied && !_isCameraError) {
      cameraController.setFlashMode(_isFlashOn ? FlashMode.off : FlashMode.torch);
      if (_isFlashOn) {
        _pageText![2] = tts!.getLanguage == "English" ? "Turn on flashlight" : "تشغيل الفلاش";
        _speakSelected(tts!.getLanguage == "English" ? "Flashlight turned off" : "تم إطفاء الفلاش");
      } else {
        _pageText![2] = tts!.getLanguage == "English" ? "Turn off flashlight" : "إطفاء الفلاش";
        _speakSelected(tts!.getLanguage == "English" ? "Flashlight turned on" : "تم تشغيل الفلاش");
      }
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    }
  }

  void _togglePause() {
    if (_isCameraInitialized && !_isAccessDenied && !_isCameraError) {
      if (_isPaused) {
        cameraController.resumePreview();
        _pageText![4] = tts!.getLanguage == "English" ? "Pause the Camera" : "إيقاف الكاميرا";
        _speakSelected(tts!.getLanguage == "English" ? "Camera resumed" : "تم استئناف الكاميرا");
      } else {
        cameraController.pausePreview();
        _pageText![4] = tts!.getLanguage == "English" ? "Resume the Camera" : "استئناف الكاميرا";
        _speakSelected(tts!.getLanguage == "English" ? "Camera paused" : "تم إيقاف الكاميرا");
      }
      setState(() {
        _isPaused = !_isPaused;
      });
    }
  }

  void _turnOffFlash() {
    if (_isCameraInitialized && !_isAccessDenied && !_isCameraError) {
      if (_isFlashOn) {
        cameraController.setFlashMode(FlashMode.off);
        setState(() {
          _isFlashOn = false;
        });
      }
    }
  }

  Future<void> _speak() async {
    await flutterTts!.speak(_pageText![_counter]);
  }

  Future<void> _speakSelected(String text) async {
    await flutterTts!.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (_counter == 0) {
          _turnOffFlash();
          Navigator.pushNamed(context, '/home');
        } else if (_counter == 2) {
          _toggleFlash();
        } else if (_counter == 4) {
          _togglePause();
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
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 80,
                titleTextStyle: textTheme(context).titleLarge!,
                centerTitle: true,
                iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary, size: 32),
                leading: GestureDetector(
                  onDoubleTap: () {
                    _setCounter(0);
                    _speak();
                  },
                  onLongPress: () {
                    _turnOffFlash();
                    Navigator.pushNamed(context, '/home');
                  },
                  child:
                      const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0), child: Icon(Icons.arrow_back_rounded)),
                ),
                title: GestureDetector(
                  onDoubleTap: () {
                    _setCounter(1);
                    _speak();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 4,
                          color: _counter == 1 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                    ),
                    child: Text(
                      tts!.getLanguage == "English" ? "OR" : "ت.ش",
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onDoubleTap: () {
                      _setCounter(2);
                      _speak();
                    },
                    onLongPress: () {
                      _toggleFlash();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Icon(_isFlashOn ? Icons.flash_off : Icons.flash_on),
                    ),
                  ),
                ],
              ),
              body: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: _isCameraInitialized &&
                            cameraController.value.isInitialized &&
                            !_isAccessDenied &&
                            !_isCameraError
                        ? cameraController.value.aspectRatio
                        : MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                    child: CameraPreview(
                      cameraController,
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: 70,
                  color: Theme.of(context).colorScheme.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          _setCounter(3);
                          _speak();
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 4,
                                color: _counter == 3 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                          ),
                          child: Text(
                            _pageText![3],
                            style: textTheme(context).labelLarge!,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: () {
                          _setCounter(4);
                          _speak();
                        },
                        onLongPress: () {
                          _togglePause();
                        },
                        child: Icon(!_isPaused ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            size: 35, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
