import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_doctor_buddy/services/bot_services.dart';
import 'package:my_doctor_buddy/services/firestore_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ChatController extends GetxController {
  late CameraController cameraController;
  List<CameraDescription> cameras = [];
  TextEditingController queryController = TextEditingController();
  RxList<Content> chatHistory = <Content>[].obs;
  RxBool isStopGenerating = false.obs;
  ScrollController scrollController = ScrollController();
  FirestoreServices _firestoreServices = FirestoreServices();
  Rx<File?> selectedImage = Rx<File?>(null);

  final aiChatSession = AIChatSession();
  String? activeChatId;
  bool isNewChat = true;

  @override
  void onInit() {
    super.onInit();

    ever(chatHistory, (_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });

    _initChat();
  }

  Future<void> _initChat() async {
    if (activeChatId == null) {
      // Set as new chat
      isNewChat = true;
    }
  }

  Future<void> loadChatById(String chatId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      activeChatId = chatId;
      chatHistory.clear();

      final messagesSnap =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('chats')
              .doc(chatId)
              .collection('messages')
              .orderBy('timestamp')
              .get();

      for (var doc in messagesSnap.docs) {
        final data = doc.data();
        final role = data['role'];
        final message = data['content'];

        if (role == 'user') {
          chatHistory.add(Content.text(message));
        } else if (role == 'bot') {
          chatHistory.add(Content.model([TextPart(message)]));
        }
      }

      log("Loaded chat: $chatId");
      update();
    } catch (e) {
      log("❌ Error loading chat: $e");
    }
  }

  Future<void> sendMessage() async {
    final userMessage = queryController.text.trim();
    if (userMessage.isEmpty) return;

    if (selectedImage.value != null) {
      final bytes = await selectedImage!.value!.readAsBytes();
      chatHistory.add(
        Content.multi([DataPart('image/jpeg', bytes), TextPart(userMessage)]),
      );
    } else {
      chatHistory.add(Content.text(userMessage));
    }

    // If it's a new chat, create one using user's first message as the title
    if (isNewChat) {
      activeChatId = await _firestoreServices.createNewChat(userMessage);
      isNewChat = false;
    }

    await _firestoreServices.addMessageToChat(
      chatId: activeChatId!,
      role: 'user',
      content: userMessage,
    );

    queryController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    isStopGenerating.value = true;
    selectedImage.value = null;

    String botResponse = "";
    final responseStream = aiChatSession.sendMessageStream(
      userMessage,
      imageUrl: selectedImage.value?.path,
    );

    responseStream.listen(
      (chunk) {
        log("AI replied chunk: $chunk");
        botResponse += chunk;
      },
      onDone: () async {
        if (botResponse.isNotEmpty) {
          chatHistory.add(Content.model([TextPart(botResponse)]));
          await _firestoreServices.addMessageToChat(
            chatId: activeChatId!,
            role: 'bot',
            content: botResponse,
          );
        }
        isStopGenerating.value = false;
      },
      onError: (e) {
        log("Error in AI stream: $e");
        chatHistory.add(
          Content.model([TextPart("⚠️ Error. Please try again.")]),
        );
        isStopGenerating.value = false;
      },
    );
  }

  Future<void> openCamera() async {
    await _ensureCameraInitialized();

    if (await Permission.camera.request().isGranted) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        log("Captured Image: $selectedImage");
      } else {
        log("Camera capture cancelled");
      }
    } else {
      _showPermissionDialog("Camera access is required to take photos.");
    }
  }

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
      update();
    } catch (e) {
      log("Camera initialization error: $e");
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final bool permissionGranted = await _handleGalleryPermission();
      if (!permissionGranted) {
        _showPermissionDialog("Gallery access is required to select images.");
        return;
      }

      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        selectedImage.value = File(picked.path);
        update();
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

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

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      throw Exception("Camera permission not granted");
    }
  }

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
                const SizedBox(width: 5),
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

  @override
  void onClose() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    super.onClose();
  }
}
