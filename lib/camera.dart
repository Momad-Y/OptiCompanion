import 'package:camera/camera.dart';

AppCamera mainAppCamera = AppCamera();

class AppCamera {
  late List<CameraDescription> cameras;

  Future<List<CameraDescription>> initCameras() async {
    cameras = await availableCameras();
    return cameras;
  }
}
