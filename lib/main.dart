import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/onboarding/presentation/onboarding_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
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
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: OnboardingScreen(),
        );
      },
    ),
  );
}
