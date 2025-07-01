import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/services/account_service.dart.dart';

class DoctorBuddyController extends GetxController {
  RxInt hours = DateTime.now().hour.obs;
  RxString greetingsMessage = "".obs;
  RxList<Map<dynamic, dynamic>> chatHistory = [{}].obs;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // ✅ Called when controller is initialized
    log("Controller Initialized");
    updateGreetingMessage();
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
      final docRef = db
          .collection("users")
          .doc(AccountService.currentUserEmail);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          log(data.toString());
          chatHistory.value = List<Map<dynamic, dynamic>>.from(data["qna"]);
          update();
          // ...
          isLoading.value = false;
        },
        onError: (e) {
          print("Error getting document: $e");
        },
      );
    } catch (e) {}
  }
}
