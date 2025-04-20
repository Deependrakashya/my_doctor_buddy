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
              onPageChanged:
                  (value) => onboardingController.updateCurrentPage(value),
              children: [
                OnboardingWidgets.customPage(
                  imgUrl: "assets/illustrations/1.png",
                  heading: " Welcome to Your Health Companion",
                  subHeading:
                      "Track your health, manage records, and stay informed—all in one place.​",
                ),
                OnboardingWidgets.customPage(
                  imgUrl: "assets/illustrations/2.png",
                  heading: "Your Health, Simplified",
                  subHeading:
                      " Access medical records, receive personalized insights, and schedule appointments effortlessly.​​",
                ),
                OnboardingWidgets.customPage(
                  imgUrl: "assets/illustrations/3.png",
                  heading: " Ready to Take Control?",
                  subHeading:
                      " Let's set up your profile and begin your journey to better health.​​",
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
              onDotClicked: (index) {
                log(index.toString());
                onboardingController.pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
            SizedBox(height: 5.h),
            Obx(() {
              return CommonWidgets.customButton(
                ontap: () {
                  if (onboardingController.currentPage.value != 2) {
                    onboardingController.pageController.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    );

                    log(
                      "next pressed ${onboardingController.currentPage.value} ",
                    );
                  }
                },
                title:
                    onboardingController.currentPage.value != 2
                        ? "Next"
                        : "Continue",
              );
            }),
          ],
        ),
      ),
    );
  }
}
