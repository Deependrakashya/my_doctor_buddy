import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/auth/presentation/auth_screen.dart';
import 'package:my_doctor_buddy/core/services/onboarding_service.dart';
import 'package:my_doctor_buddy/home.dart';
import 'package:my_doctor_buddy/onboarding/presentation/onboarding_screen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isOnboardingCompleted =
      await OnboardingService().isOnboardingCompleted();
  await Firebase.initializeApp();
  log(" firebase auth ${FirebaseAuth.instance.currentUser}");

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: "Albert_Sans",

            textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
            scaffoldBackgroundColor: Colors.transparent,

            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.transparent,
            ),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.sp),
                  topRight: Radius.circular(25.sp),
                ),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home:
              isOnboardingCompleted
                  ? FirebaseAuth.instance.currentUser == null
                      ? AuthScreen()
                      : Home()
                  : OnboardingScreen(),
        );
      },
    ),
  );
}
