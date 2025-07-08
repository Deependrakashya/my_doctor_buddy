import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/screens/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/services/account_service.dart.dart';
import 'package:my_doctor_buddy/viewModel/chat_controller.dart';
import 'package:my_doctor_buddy/views/chat/all_chat_screen.dart';
import 'package:my_doctor_buddy/views/chat/chat_screen.dart';
import 'package:my_doctor_buddy/viewModel/doctor_buddy_controller.dart';
import 'package:my_doctor_buddy/views/chat/doctor_buddy_widgets.dart';
import 'package:my_doctor_buddy/views/chat_details/chat_details_screen.dart';
import 'package:my_doctor_buddy/views/common/glass_background.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DoctorBuddyScreen extends StatefulWidget {
  DoctorBuddyScreen({super.key});

  @override
  State<DoctorBuddyScreen> createState() => _DoctorBuddyScreenState();
}

class _DoctorBuddyScreenState extends State<DoctorBuddyScreen> {
  final DoctorBuddyController buddyController = Get.put(
    DoctorBuddyController(),
  );

  final DoctorBuddyWidgets doctorBuddyWidgets = DoctorBuddyWidgets();
  @override
  void initState() {
    super.initState();
    buddyController.fetchChatHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                          "${buddyController.greetingsMessage}",
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
                      Text(
                        "Recent Chats",
                        style: customTextStyle16(Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(
                            AllChatScreen(buddyController: buddyController),
                          );
                        },
                        child: Text(
                          "View All",
                          style: customTextStyle16(
                            const Color.fromARGB(255, 186, 181, 181),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return buddyController.isLoading.value
                      ? Skeletonizer(
                        effect: ShimmerEffect.raw(
                          colors: [
                            const Color.fromARGB(111, 255, 255, 255),
                            const Color.fromARGB(146, 255, 255, 255),
                          ],
                          // from: Colors.white,
                          // to: Colors.black,
                          tileMode: TileMode.mirror,
                          duration: Duration(milliseconds: 1500),
                        ),

                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                top: 1.h,
                                left: 2.w,
                                right: 2.w,
                              ),
                              child: doctorBuddyWidgets.ChatListTile(
                                ontap: () {},
                                title:
                                    "this is a chat title may be defferenet for other times ",
                              ),
                            );
                          },
                        ),
                      )
                      : buddyController.chatHistory.isNotEmpty
                      ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(), // optional
                        itemBuilder: (context, index) {
                          final chat = buddyController.chatHistory[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 1.h,
                              horizontal: 2.w,
                            ),
                            child: doctorBuddyWidgets.ChatListTile(
                              ontap: () async {
                                final selectedChatId =
                                    buddyController
                                        .chatHistory[index]['chatId'];
                                // log(
                                //   buddyController.chatHistory[index].toString(),
                                // );
                                // or however you're storing chat ID
                                // await ChatController().loadChatById(
                                //   selectedChatId,
                                // );

                                Get.to(
                                  () => ChatDetailsScreen(
                                    chatData:
                                        buddyController.chatHistory[index],
                                  ),
                                ); // or your AI chat screen
                              },
                              title: chat['title'] ?? 'Untitled Chat',
                            ),
                          );
                        },
                      )
                      : Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: GlassBackground(
                          height: 200,

                          child: Center(
                            child: Text(
                              "No Chat History yet !",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                }),
              ],
            ),

            Positioned(
              bottom: 2.h,
              right: 2.w,
              child: Container(
                height: 8.h,
                width: 90.w,
                margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                child: doctorBuddyWidgets.NewChatButton(
                  title: "Ask Something ",
                  ontap: () {
                    Get.to(
                      ChatScreen(),
                      transition: Transition.fadeIn,
                      duration: Duration(seconds: 2),
                    );
                  },
                ),
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
