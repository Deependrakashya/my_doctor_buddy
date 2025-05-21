import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/presentations/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/doctor_buddy/presentation/doctor_buddy_controller.dart';
import 'package:sizer/sizer.dart';

class DoctorBuddyScreen extends StatelessWidget {
  DoctorBuddyScreen({super.key});
  final DoctorBuddyController _buddyController = Get.put(
    DoctorBuddyController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Obx(() {
                  return Text(
                    "${_buddyController.greetingsMessage}",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: "Albert_Sans",
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
