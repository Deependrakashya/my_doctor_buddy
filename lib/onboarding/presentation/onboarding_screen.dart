import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/presentations/background_ui.dart';
import 'package:my_doctor_buddy/common/widgets/common_widgets.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';
import 'package:my_doctor_buddy/onboarding/domain/controller/onboarding_controller.dart';
import 'package:my_doctor_buddy/onboarding/presentation/onboarding_widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  OnboardingController onboardingController = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundUi.customBgUi(),
          SafeArea(
            child: PageView(
              controller: onboardingController.pageController,
              children: [
                OnboardingWidgets.customPage(
                  imgUrl: "assets/illustrations/1.png",
                  heading: " Welcome to Your Health Companion",
                  subHeading:
                      "Track your health, manage records, and stay informed—all in one place.​",
                ),
                OnboardingWidgets.customPage(
                  imgUrl: "assets/illustrations/2.png",
                  heading: " Welcome to Your Health Companion",
                  subHeading:
                      "Track your health, manage records, and stay informed—all in one place.​",
                ),
                OnboardingWidgets.customPage(
                  imgUrl: "assets/illustrations/3.png",
                  heading: " Welcome to Your Health Companion",
                  subHeading:
                      "Track your health, manage records, and stay informed—all in one place.​",
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 30.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SmoothPageIndicator(
              controller: onboardingController.pageController,
              count: 3,
              effect: JumpingDotEffect(
                activeDotColor: green,
                dotHeight: 9.68,
                dotWidth: 9.68,
                spacing: 4,
                dotColor: const Color.fromRGBO(225, 225, 225, 1),
              ),
              onDotClicked:
                  (index) => onboardingController.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
            ),
            SizedBox(height: 5.h),

            CommonWidgets.customButton(
              ontap: () {
                log("next pressed");
                onboardingController.pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInCirc,
                );
              },
              title: "Next",
            ),
          ],
        ),
      ),
    );
  }
}
