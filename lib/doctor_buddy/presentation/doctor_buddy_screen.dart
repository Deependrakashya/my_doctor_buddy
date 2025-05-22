import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/presentations/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/core/services/account_service.dart.dart';
import 'package:my_doctor_buddy/doctor_buddy/presentation/chat_screen.dart';
import 'package:my_doctor_buddy/doctor_buddy/presentation/doctor_buddy_controller.dart';
import 'package:my_doctor_buddy/doctor_buddy/presentation/widgets/doctor_buddy_widgets.dart';
import 'package:sizer/sizer.dart';

class DoctorBuddyScreen extends StatelessWidget {
  DoctorBuddyScreen({super.key});
  final DoctorBuddyController _buddyController = Get.put(
    DoctorBuddyController(),
  );
  final DoctorBuddyWidgets doctorBuddyWidgets = DoctorBuddyWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar Greeting with Name
            Obx(() {
              return Container(
                margin: EdgeInsets.only(left: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_buddyController.greetingsMessage}",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: "Albert_Sans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AccountService.currentUserName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent Chats", style: customTextStyle16(Colors.white)),
                  Text(
                    "View All",
                    style: customTextStyle16(
                      const Color.fromARGB(255, 186, 181, 181),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 55.h,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
                    child: doctorBuddyWidgets.ChatListTile(
                      ontap: () {},
                      title:
                          "this is a chat title may be defferenet for other times ",
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.5.w),
              child: doctorBuddyWidgets.NewChatButton(
                ontap: () {
                  Get.to(
                    ChatScreen(),
                    transition: Transition.fadeIn,
                    duration: Duration(seconds: 2),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // bottomSheet: Container(
      //   height: 40.h,
      //   width: 100.w,
      //   margin: EdgeInsets.only(bottom: 6.h),
      //   decoration: BoxDecoration(
      //     color: Colors.amber,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(25.sp),
      //       topRight: Radius.circular(25.sp),
      //     ),
      //     gradient: LinearGradient(
      //       colors: [
      //         Color.fromARGB(255, 227, 248, 255),
      //         Color.fromARGB(255, 232, 233, 248),
      //       ],
      //     ),
      //   ),
      //   child: Text("data"),
      // ),
    );
  }

  TextStyle customTextStyle16(Color color) {
    return TextStyle(
      color: color,
      fontSize: 17.sp,
      fontWeight: FontWeight.w600,
    );
  }
}
