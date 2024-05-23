import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import '../tts.dart';

import '../themes.dart';

import '../camera.dart';
import 'package:camera/camera.dart';
import '../model.dart';

Map<String, String> translator = {
  "person": "شخص",
  "bicycle": "دراجة",
  "car": "سيارة",
  "motorcycle": "دراجة نارية",
  "airplane": "طائرة",
  "bus": "حافلة",
  "train": "قطار",
  "truck": "شاحنة",
  "boat": "قارب",
  "traffic light": "إشارة مرور",
  "fire hydrant": "مطفأة حريق",
  "stop sign": "إشارة توقف",
  "parking meter": "عداد وقوف السيارات",
  "bench": "مقعد",
  "bird": "طائر",
  "cat": "قط",
  "dog": "كلب",
  "horse": "حصان",
  "sheep": "خروف",
  "cow": "بقرة",
  "elephant": "فيل",
  "bear": "دب",
  "zebra": "حمار وحشي",
  "giraffe": "زرافة",
  "backpack": "ظهرية",
  "umbrella": "مظلة",
  "handbag": "حقيبة يد",
  "tie": "ربطة عنق",
  "suitcase": "حقيبة سفر",
  "frisbee": "طبق",
  "skis": "زلاجات",
  "snowboard": "لوح تزلج",
  "sports ball": "كرة رياضية",
  "kite": "طائرة ورقية",
  "baseball bat": "مضرب البيسبول",
  "baseball glove": "قفاز البيسبول",
  "skateboard": "لوح تزلج",
  "surfboard": "لوح ركوب الأمواج",
  "tennis racket": "مضرب تنس",
  "bottle": "زجاجة",
  "wine glass": "كأس نبيذ",
  "cup": "كوب",
  "fork": "شوكة",
  "knife": "سكين",
  "spoon": "ملعقة",
  "bowl": "وعاء",
  "banana": "موز",
  "apple": "تفاحة",
  "sandwich": "ساندويتش",
  "orange": "برتقال",
  "broccoli": "بروكلي",
  "carrot": "جزر",
  "hot dog": "سجق",
  "pizza": "بيتزا",
  "donut": "دونات",
  "cake": "كعكة",
  "chair": "كرسي",
  "couch": "أريكة",
  "potted plant": "نبات مزروع",
  "bed": "سرير",
  "dining table": "طاولة طعام",
  "toilet": "مرحاض",
  "tv": "تلفاز",
  "laptop": "حاسوب محمول",
  "mouse": "فأرة",
  "remote": "ريموت",
  "keyboard": "لوحة مفاتيح",
  "cell phone": "هاتف خلوي",
  "microwave": "ميكروويف",
  "oven": "فرن",
  "toaster": "محمصة",
  "sink": "حوض",
  "refrigerator": "ثلاجة",
  "book": "كتاب",
  "clock": "ساعة",
  "vase": "مزهرية",
  "scissors": "مقص",
  "teddy bear": "دبدوب",
  "hair drier": "مجفف شعر",
  "toothbrush": "فرشاة أسنان",
};

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

  CameraController? cameraController;
  late AppCamera appCamera;

  bool _isCameraOn = false;
  bool _isFlashOn = false;
  bool _isPaused = false;
  bool _isCameraError = false;
  bool _isAccessDenied = false;

  String predictionResult = "";

  final List<String> _pageTextEn = [
    "Previous page",
    "Object Recognition Page",
    "Turn on flashlight",
    "",
    "Pause the Camera",
  ];

  final List<String> _pageTextAr = [
    "الصفحة السابقة",
    "صفحة التعرف على الأشياء",
    "تشغيل الفلاش",
    "",
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

  String alreadySaid = "Nothing";

  @override
  initState() {
    appCamera = mainAppCamera;
    super.initState();
    _initialize();
    tts = mainTts;
    tts!.initPrefs().then((_) => {
          flutterTts = tts!.initTts(true),
          _speak(),
          _speakSelected(tts!.getLanguage() == "English"
              ? "Detected objects will be read out loud starting from the left to the right and displayed on the screen."
              : "سيتم قراءة الأشياء المكتشفة بصوت عالي من اليسار إلى اليمين وعرضها على الشاشة."),
        });
    _pageText = tts!.getLanguage() == "English" ? _pageTextEn : _pageTextAr;
    _errorText = tts!.getLanguage() == "English" ? _errorTextEn : _errorTextAr;
    predictionResult = tts!.getLanguage() == "English" ? "No objects detected" : "لم يتم الكشف عن أي أشياء";
    _pageText![3] = predictionResult;
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

  Future<void> _initialize() async {
    AppTfliteModel.loadObjectDetectionModel();
    cameraController = CameraController(appCamera.cameras[0], ResolutionPreset.ultraHigh);
    cameraController!.initialize().then((_) {
      if (!mounted) return;

      setState(() {
        _isCameraOn = true;
        _isAccessDenied = false;
        _isCameraError = false;
      });
      _startImageStream();
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

  void _startImageStream() {
    if (!AppTfliteModel.getIsObjectDetectionModelLoaded || _isAccessDenied || _isCameraError || _isPaused) {
      return;
    }

    cameraController!.startImageStream((cameraImage) async {
      var predictions = await AppTfliteModel.objectdetectionStream(cameraImage);

      if (_isPaused) {
        setState(() {
          _pageText![3] = tts!.getLanguage() == "English" ? "Camera is paused" : "تم إيقاف الكاميرا";
        });
        return;
      }

      if (predictions == null || predictions.isEmpty) {
        return;
      }

      // Get the top 3 predictions based on the confidence level
      List top3Predictions = [];

      for (var prediction in predictions) {
        if (prediction["confidenceInClass"] > 0.55) {
          top3Predictions.add(prediction);
        }
      }

      // Sort the elements from the left to the right
      top3Predictions.sort((a, b) => a["rect"]["x"].compareTo(b["rect"]["x"]));

      // Get the detected objects names
      List detectedObjectsEn = top3Predictions.map((prediction) => prediction["detectedClass"]).toList();
      // Capitalize the first letter of each detected object name
      detectedObjectsEn = detectedObjectsEn.map((object) => object[0].toUpperCase() + object.substring(1)).toList();

      List detectedObjectsAr = detectedObjectsEn.map((object) => translator[object.toLowerCase()]).toList();
      List detectedObjects = tts!.getLanguage() == "English" ? detectedObjectsEn : detectedObjectsAr;

      // Concatenate the detected objects names
      predictionResult = detectedObjects.join(" | ");
      if (predictionResult.isEmpty) {
        predictionResult = tts!.getLanguage() == "English" ? "No objects detected" : "لم يتم الكشف عن أي أشياء";
        alreadySaid = "Nothing";
      } else {
        predictionResult = tts!.getLanguage() == "English"
            ? predictionResult = "Detected objects: $predictionResult"
            : "الأشياء المكتشفة: $predictionResult";
      }
      setState(() {
        _pageText![3] = predictionResult;
        if (detectedObjects.isNotEmpty && detectedObjects[0] != alreadySaid) {
          alreadySaid = detectedObjects[0];
          _speakSelected(detectedObjects[0]);
        }
      });
    });
  }

  void _toggleFlash() {
    if (_isCameraOn && !_isAccessDenied && !_isCameraError) {
      cameraController!.setFlashMode(_isFlashOn ? FlashMode.off : FlashMode.torch);
      if (_isFlashOn) {
        _pageText![2] = tts!.getLanguage() == "English" ? "Turn on flashlight" : "تشغيل الفلاش";
        _speakSelected(tts!.getLanguage() == "English" ? "Flashlight turned off" : "تم إطفاء الفلاش");
      } else {
        _pageText![2] = tts!.getLanguage() == "English" ? "Turn off flashlight" : "إطفاء الفلاش";
        _speakSelected(tts!.getLanguage() == "English" ? "Flashlight turned on" : "تم تشغيل الفلاش");
      }
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    }
  }

  void _togglePause() {
    if (_isCameraOn && !_isAccessDenied && !_isCameraError) {
      if (_isPaused) {
        cameraController!.resumePreview();
        _pageText![4] = tts!.getLanguage() == "English" ? "Pause the Camera" : "إيقاف الكاميرا";
        _speakSelected(tts!.getLanguage() == "English" ? "Camera resumed" : "تم استئناف الكاميرا");
      } else {
        cameraController!.pausePreview();
        _pageText![4] = tts!.getLanguage() == "English" ? "Resume the Camera" : "استئناف الكاميرا";
        _speakSelected(tts!.getLanguage() == "English" ? "Camera paused" : "تم إيقاف الكاميرا");
      }
      setState(() {
        _isPaused = !_isPaused;
      });
    }
  }

  void _turnOffFlash() {
    if (_isCameraOn && !_isAccessDenied && !_isCameraError) {
      if (_isFlashOn) {
        cameraController!.setFlashMode(FlashMode.off);
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
          _isCameraOn = false;
          AppTfliteModel.closeModel();
          cameraController!.dispose();
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
                    _isCameraOn = false;
                    AppTfliteModel.closeModel();
                    cameraController!.dispose();
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
                      tts!.getLanguage() == "English" ? "OR" : "ت.ش",
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
                    aspectRatio:
                        _isCameraOn && cameraController!.value.isInitialized && !_isAccessDenied && !_isCameraError
                            ? cameraController!.value.aspectRatio
                            : MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                    child: CameraPreview(
                      cameraController!,
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {},
                child: GestureDetector(
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
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 4,
                                color: _counter == 3 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                          ),
                          child: Center(
                            child: Text(
                              _pageText![3],
                              style: textTheme(context).displayMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
