import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/screens/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/viewModel/doctor_buddy_controller.dart';
import 'package:my_doctor_buddy/views/chat/chat_widgets.dart';
import 'package:my_doctor_buddy/views/chat/doctor_buddy_widgets.dart';
import 'package:my_doctor_buddy/views/chat_details/chat_details_screen.dart';
import 'package:my_doctor_buddy/views/common/glass_background.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllChatScreen extends StatefulWidget {
  final DoctorBuddyController buddyController;

  AllChatScreen({super.key, required this.buddyController});

  @override
  State<AllChatScreen> createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  final DoctorBuddyWidgets doctorBuddyWidgets = DoctorBuddyWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BgUiWithoutCirucles(),
          SafeArea(
            child: Column(
              children: [
                ChatWidgets.customChatAppBar(title: "All Chats"),
                Obx(() {
                  return widget.buddyController.isLoading.value
                      ? Expanded(
                        child: Skeletonizer(
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
                            itemCount: 10,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  top: 1.h,
                                  left: 2.w,
                                  right: 2.w,
                                ),
                                child: DoctorBuddyWidgets().ChatListTile(
                                  ontap: () {},
                                  title:
                                      "this is a chat title may be defferenet for other times ",
                                ),
                              );
                            },
                          ),
                        ),
                      )
                      : widget.buddyController.chatHistory.length >= 1
                      ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: widget.buddyController.chatHistory.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          // reverse: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                top: 1.h,
                                left: 2.w,
                                right: 2.w,
                              ),
                              child: doctorBuddyWidgets.ChatListTile(
                                ontap: () {
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
                                          widget
                                              .buddyController
                                              .chatHistory[index],
                                    ),
                                  ); // or your AI chat screen
                                },
                                title:
                                    widget
                                        .buddyController
                                        .chatHistory[index]["title"] ??
                                    "null",
                              ),
                            );
                          },
                        ),
                      )
                      : Container(
                        height: 70.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
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
                            ),
                          ],
                        ),
                      );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
