import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:tflite_v2/tflite_v2.dart';

class AppTfliteModel {
  static bool _isModelLoaded = false;
  static int _lastProcessedTime = DateTime.now().millisecondsSinceEpoch;

  static bool get getIsModelLoaded => _isModelLoaded;

  static Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/models/ssd_mobilenet.tflite",
        labels: "assets/models/labels.txt",
      );
      _isModelLoaded = true;
    } catch (e) {
      log("Failed to load model: $e");
    }
  }

  static Future<List?> classifyStream(CameraImage cameraImage) async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - _lastProcessedTime < 1000) {
      return null;
    }
    _lastProcessedTime = currentTime;
    try {
      var result = await Tflite.detectObjectOnFrame(
        bytesList: cameraImage.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        model: "SSDMobileNet",
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResultsPerClass: 1,
        threshold: 0.4,
      );
      return result;
    } catch (e) {
      log("Failed to run model inference: $e");
      return null;
    }
  }

  static Future<void> closeModel() async {
    await Tflite.close();

    _isModelLoaded = false;
  }
}
