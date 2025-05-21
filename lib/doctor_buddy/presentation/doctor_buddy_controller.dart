import 'dart:developer';

import 'package:get/get.dart';

class DoctorBuddyController extends GetxController {
  RxInt hours = DateTime.now().hour.obs;
  RxString greetingsMessage = "".obs;
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
}
