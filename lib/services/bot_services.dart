import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class AIChatSession {
  static final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";
  static final String modelName =
      'gemini-2.0-flash'; // Replace with actual model name
  StreamController<String>? _controller;
  StreamSubscription<GenerateContentResponse>? _subscription;

  final GenerativeModel model;
  late ChatSession chatSession;

  final String chatCollection = 'chat_history';

  final String botName = "My Doctor Buddy";
  final String creatorName = "";
  // Restore history if available, else start fresh

  AIChatSession()
    : model = GenerativeModel(
        model: modelName,
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.5,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
        ),
        safetySettings: [
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        ],
      ) {
    chatSession = model.startChat(history: _getInitialMessages());
  }

  /// Sends a user message and streams the response
  Stream<String> sendMessageStream(String message, {String? imageUrl}) {
    _controller?.close(); // close any old controller
    _controller = StreamController<String>();

    try {
      final content = Content.multi([
        if (imageUrl != null)
          DataPart('image/jpeg', File(imageUrl).readAsBytesSync()),
        TextPart(message),
      ]);

      _subscription = chatSession
          .sendMessageStream(content)
          .listen(
            (res) {
              if (res.text != null) {
                _controller?.add(res.text!);
              }
            },
            onError: (err) {
              log("❌ Error during stream: $err");
              _controller?.addError(err);
            },
            onDone: () {
              _controller?.close();
            },
          );
    } catch (e, stack) {
      log("❌ Error while starting stream: $e");
      log("📛 Stacktrace: $stack");
      _controller?.addError(e);
      _controller?.close();
    }

    return _controller!.stream;
  }

  void cancelStream() {
    _subscription?.cancel();
    _controller?.close();
    _subscription = null;
    _controller = null;
    log("✅ Stream cancelled.");
  }

  // Future<void> _addMessageToFirebase(
  //   String text, {
  //   required bool isUser,
  //   String? imageUrl,
  // }) async {
  //   await _firestore.collection(chatCollection).add({
  //     'sender': isUser ? 'user' : 'bot',
  //     'message': text,
  //     'timestamp': FieldValue.serverTimestamp(),
  //     'imageUrl': imageUrl,
  //   });
  // }

  // Future<String> uploadImageToFirebase(XFile image) async {
  //   final ref = _storage.ref().child(
  //     'chat_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
  //   );
  //   await ref.putFile(File(image.path));
  //   return await ref.getDownloadURL();
  // }

  Future<Uint8List> _getBytesFromUrl(String url) async {
    final file = File(url);
    return await file.readAsBytes(); // This returns Uint8List
  }

  List<Content> _getInitialMessages() {
    return [
      Content.text("Who are you?"),
      Content.model([
        TextPart(
          "👋 Hi! I'm *My Doctor Buddy*, your personal medical assistant.I developed by a passionate team of SIMT Shahjahanpur students committed to advancing medical technology."
          "I specialize in providing health guidance, symptom insights, and wellness tips tailored to you. "
          "I'm not affiliated with any third-party AI company — I'm just your Doctor Buddy, always here to help.",
        ),
      ]),
      Content.text("What can you help with?"),
      Content.model([
        TextPart(
          "I'm here to support you with:\n"
          "🩺 Understanding symptoms\n"
          "💊 Medicine usage guidance\n"
          "🥗 Healthy lifestyle suggestions\n"
          "📅 Tracking your health questions\n\n"
          "All information stays secure and private.",
        ),
      ]),
      Content.text("Who trained You?"),
      Content.model([
        TextPart(
          " I'm *My Doctor Buddy*,and I developed and trained  by a passionate team of SIMT Shahjahanpur students committed to advancing medical technology. built with love to assist you with medical concerns. "
          "I work independently to offer accurate and helpful health information. You’re in good hands.",
        ),
      ]),
      Content.text(
        "Provide me information related without disclaimer or any thing like I'm AI and I cannot do that and dont suggest to visit doctor first provide some verfied medicine and things which can help to get rid off illness. And whenever new Report Image provided try to find the problematic thing in this and explain  me in clearly language ",
      ),
      Content.model([TextPart("Yes I got it . I'll take care of it ")]),
    ];
  }
}
