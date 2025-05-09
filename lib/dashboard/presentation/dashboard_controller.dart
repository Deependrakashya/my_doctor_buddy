import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';
import 'package:my_doctor_buddy/core/services/account_service.dart.dart';
import 'package:my_doctor_buddy/core/services/google_auth.dart';
import 'package:my_doctor_buddy/core/services/onboarding_service.dart';
import 'package:my_doctor_buddy/onboarding/presentation/onboarding_screen.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;
  Future<void> switchToGoogleSignUp() async {
    isLoading.value = true;
    try {
      var res = await AuthService().signInWithGoogle();
      if (res != null) {
        isLoading.value = false;
        Get.snackbar("Google Sign Up Succeeded", '', colorText: green);
      }
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Something went wrong",
        colorText: Color.fromARGB(255, 255, 0, 0),
      );
      log("got erro google sign up $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logOut() async {
    isLoading.value = true;
    try {
      GoogleSignInAccount? res = await AuthService().signOut();
      OnboardingService().removeOnboarding();
      if (res?.id == null) {
        isLoading.value = false;
        Get.to(OnboardingScreen());
      }
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Something went wrong",
        colorText: Color.fromARGB(255, 255, 0, 0),
      );
      isLoading.value = false;
    }
  }
}
