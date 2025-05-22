import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ChatController extends GetxController {
  late CameraController cameraController;
  List<CameraDescription> cameras = [];
  File? selectedImage;

  /// Opens native camera and captures image
  Future<void> openCamera() async {
    await _ensureCameraInitialized();

    if (await Permission.camera.request().isGranted) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        log("Captured Image: $selectedImage");
      } else {
        log("Camera capture cancelled");
      }
    } else {
      _showPermissionDialog("Camera access is required to take photos.");
    }
  }

  /// Initializes available cameras and sets up the controller
  Future<void> _ensureCameraInitialized() async {
    try {
      await _requestCameraPermission();

      cameras = await availableCameras();
      final firstCamera = cameras.first;

      cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController.initialize();
      update(); // triggers GetBuilder/UI rebuild
    } catch (e) {
      log("Camera initialization error: $e");
    }
  }

  /// Requests camera permission
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      throw Exception("Camera permission not granted");
    }
  }

  /// Pick image from gallery with smart permission handling (iOS + Android)
  Future<void> pickImageFromGallery() async {
    try {
      final bool permissionGranted = await _handleGalleryPermission();
      if (!permissionGranted) {
        _showPermissionDialog("Gallery access is required to select images.");
        return;
      }

      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        selectedImage = File(picked.path);
        log("Selected Image: $selectedImage");
      } else {
        log("Image selection cancelled");
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  /// Handle permission checks based on platform and Android SDK version
  Future<bool> _handleGalleryPermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      return sdkInt >= 33
          ? (await Permission.photos.request()).isGranted
          : (await Permission.storage.request()).isGranted;
    } else if (Platform.isIOS) {
      return (await Permission.photos.request()).isGranted;
    }
    return false;
  }

  /// Show fallback permission dialog
  void _showPermissionDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text("Permission Required"),
        content: Text(message),
        contentTextStyle: TextStyle(color: Colors.green),

        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: openAppSettings,

                  child: const Text("Settings"),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Dispose camera controller safely
  @override
  void onClose() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    super.onClose();
  }
}
