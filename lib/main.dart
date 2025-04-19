import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/home.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.transparent,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.transparent,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: Home(),
        );
      },
    ),
  );
}
