import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:my_doctor_buddy/common/screens/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/viewModel/chat_controller.dart';
import 'package:my_doctor_buddy/viewModel/doctor_buddy_controller.dart';
import 'package:my_doctor_buddy/views/chat/chat_widgets.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final typewriterController = AnimatedTextController();
  final ChatController chatController = Get.put(ChatController());
  final List<String> suggestions = [
    "Flu signs?",
    "Paracetamol + Ibuprofen?",
    "Healthy meals?",
    "Headache tips?",
    "Doctor visit?",
    "Cold remedies?",
    "Best sleep hacks?",
    "Low BP cure?",
    "Skin care tips?",
    "Boost immunity?",
  ];

  double lastOffset = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    Get.find<DoctorBuddyController>().fetchChatHistory();

    Get.delete<ChatController>();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(side: BorderSide.none),
        ),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            BgUiWithoutCirucles(),

            SafeArea(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),

                child: Column(
                  children: [
                    ChatWidgets.customChatAppBar(title: "New Session"),

                    Obx(() {
                      if (chatController.chatHistory.isEmpty) {
                        return Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children:
                                suggestions.map((text) {
                                  return ActionChip(
                                    label: Text(
                                      text,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    color: WidgetStatePropertyAll(
                                      Color.fromRGBO(212, 218, 212, .1),
                                    ),

                                    onPressed: () {
                                      chatController.queryController.text =
                                          text;
                                      chatController.sendMessage();
                                    },
                                  );
                                }).toList(),
                          ),
                        );
                      }
                      return Container();
                    }),
                    Obx(() {
                      return Container(
                        height: 75.h,
                        child: ListView.builder(
                          itemCount: chatController.chatHistory.length,
                          padding: EdgeInsets.all(0),
                          controller: chatController.scrollController,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final content = chatController.chatHistory[index];
                            final isUser = content.role == 'user';

                            final widgets =
                                content.parts.map((part) {
                                  if (part is TextPart) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                      ),
                                      child:
                                          isUser
                                              ? Container(
                                                margin: EdgeInsets.only(
                                                  right: 10.sp,
                                                ),
                                                child: ChatWidgets.UserChat(
                                                  part.text,
                                                ),
                                              )
                                              : Container(
                                                margin: EdgeInsets.only(
                                                  left: 10.sp,
                                                ),
                                                child: ChatWidgets.BotChat(
                                                  part.text,
                                                ),
                                              ),
                                    );
                                  } else if (part is DataPart &&
                                      part.mimeType.startsWith('image/')) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.memory(
                                        part.bytes,
                                        height: 20.h,
                                      ),
                                    );
                                  } else {
                                    return const Text("[Unsupported content]");
                                  }
                                }).toList();

                            return Column(
                              crossAxisAlignment:
                                  isUser
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: widgets,
                            );
                          },
                        ),
                      );
                    }),

                    SizedBox(height: 200.h),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 15.h,
              left: 5.w,
              child: Obx(() {
                final image = chatController.selectedImage.value;
                if (image == null) return SizedBox.shrink();

                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.file(
                        image,
                        height: 20.h,
                        width: 20.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(173, 82, 82, 82),
                          borderRadius: BorderRadius.circular(25.sp),
                        ),
                        child: IconButton(
                          onPressed: () {
                            chatController.selectedImage.value = null;
                          },
                          icon: Icon(
                            CupertinoIcons.delete_solid,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
        bottomSheet: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60.w,
                color: Colors.transparent,
                child: Obx(() {
                  log(
                    "chatController.isStopGenerating.value ${chatController.isStopGenerating.value}",
                  );

                  return chatController.isStopGenerating.value
                      ? Container(
                        margin: EdgeInsets.only(bottom: 5.h),

                        child: ChatWidgets.stopGeneratingButton(
                          ontap: () {
                            chatController.aiChatSession.cancelStream();
                          },
                          typewriterController: typewriterController,
                        ),
                      )
                      : Container();
                }),
              ),
              Obx(() {
                log(
                  "chatController.isStopGenerating.value ${chatController.isStopGenerating.value}",
                );

                return !chatController.isStopGenerating.value
                    ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      // padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Column(
                        children: [
                          // : Container();
                          ChatWidgets.chatInput(chatController: chatController),
                        ],
                      ),
                    )
                    : Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
