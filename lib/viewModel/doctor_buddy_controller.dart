import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/services/account_service.dart.dart';

class DoctorBuddyController extends GetxController {
  RxInt hours = DateTime.now().hour.obs;
  RxString greetingsMessage = "".obs;
  RxList<Map<String, dynamic>> chatHistory = <Map<String, dynamic>>[].obs;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    log("Controller Initialized");
    updateGreetingMessage();
    fetchChatHistory();
  }

  void updateGreetingMessage() {
    if (hours < 12) {
      greetingsMessage.value = "Good Morning !!";
    } else if (hours >= 12 && hours < 17) {
      greetingsMessage.value = "Good Afternoon !!";
    } else if (hours >= 17 && hours < 20) {
      greetingsMessage.value = "Good Evening !!";
    } else {
      greetingsMessage.value = "Good Night !!";
    }
  }

  void fetchChatHistory() async {
    try {
      if (AccountService.currentUserName == "Anonymous") {
        isLoading.value = false;
        return;
      }

      final uid = AccountService.currentUserId;
      final userChatsCollection = db
          .collection("users")
          .doc(uid)
          .collection("chats");

      final chatDocs =
          await userChatsCollection
              .orderBy('updatedAt', descending: true)
              .get();

      List<Map<String, dynamic>> chatSummaries = [];

      for (final chatDoc in chatDocs.docs) {
        final messagesSnapshot =
            await userChatsCollection
                .doc(chatDoc.id)
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .limit(1)
                .get();

        final lastMessage =
            messagesSnapshot.docs.isNotEmpty
                ? messagesSnapshot.docs.first.data()
                : {};

        log(lastMessage.toString());
        chatSummaries.add({
          'chatId': chatDoc.id,
          'title': chatDoc.data()['title'] ?? 'New Chat',
          'lastMessage': lastMessage['content'] ?? '',
          'timestamp': chatDoc.data()['updatedAt'] ?? Timestamp.now(),
        });
      }

      chatHistory.value = chatSummaries;
      isLoading.value = false;
      update();
    } catch (e) {
      log("Error fetching chat history: $e");
      isLoading.value = false;
    }
  }
}
