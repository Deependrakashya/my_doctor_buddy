import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/presentations/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/doctor_buddy/presentation/chat_controller.dart';
import 'package:my_doctor_buddy/doctor_buddy/presentation/widgets/chat_widgets.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
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
                child: Column(children: [ChatWidgets.customChatAppBar()]),
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          // constraints: BoxConstraints(minHeight: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60.w,
                color: Colors.transparent,
                child: ChatWidgets.stopGeneratingButton(
                  ontap: () {},
                  typewriterController: typewriterController,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                // padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: ChatWidgets.chatInput(chatController: chatController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
