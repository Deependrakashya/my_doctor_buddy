import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  RxInt currentPage = 1.obs;
  PageController pageController = PageController();
  void updateCurrentPage(int index) {
    currentPage.value = index;
  }
}
