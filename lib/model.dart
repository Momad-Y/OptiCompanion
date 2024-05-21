import 'dart:developer';

import 'package:camera/camera.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

late List<CameraDescription> cameras;

class TfliteModel {
  late Interpreter interpreter_1;
  late Interpreter interpreter_2;

  bool isModel1Loaded = false;
  bool isModel2Loaded = false;

  Future<void> initModel(String text) async {
    if (isModel1Loaded) {
      return;
    }
    if (text == 'ocr') {
      try {
        interpreter_1 = await Interpreter.fromAsset('assets/models/east-text-detector.tflite');
        isModel1Loaded = true;
      } catch (e) {
        log('Failed to load text detector model: $e');
      }
      try {
        interpreter_2 = await Interpreter.fromAsset('assets/models/ocr.tflite');
        isModel2Loaded = true;
      } catch (e) {
        log('Failed to load text recognizer model: $e');
      }
    }
  }

  Future<void> modelStreamOCR(CameraImage cameraImage) async {
    log('Camera image dimensions: ${cameraImage.width}x${cameraImage.height}');

    // Resize the image to 320x320 to match the model's input size by holding the aspect ratio
    // final inputImage = ImageProcessor.resizeWithCropOrPad(
    //   cameraImage: cameraImage,
    //   targetHeight: 320,
    //   targetWidth: 320,
    // );

    // log('Input image dimensions: ${inputImage.width}x${inputImage.height}');
    // log('Number of channels: ${inputImage.numChannels}');
    // log('Number of bytes: ${inputImage.getBytes().length}');

    // log('Input image data type: ${inputImage.data.runtimeType}');
  }
}
