import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/viewModel/chat_controller.dart';
import 'package:sizer/sizer.dart';

class ChatWidgets {
  static Widget customChatAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.back, color: Colors.white, size: 4.h),
        ),

        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ConvoCraft: UX audit",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
              Text("free chat"),
            ],
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }

  static Widget stopGeneratingButton({
    required VoidCallback ontap,
    required AnimatedTextController typewriterController,
  }) {
    return ElevatedButton(
      onPressed: ontap,
      style: ButtonStyle(
        splashFactory: InkRipple.splashFactory,
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      child: Container(
        // width: 90.w,
        // margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 18.sp),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.sp)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(CupertinoIcons.stop, size: 20),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Stop Generating ', // 🧍 Static part
                  style: TextStyle(fontSize: 15.sp, color: Colors.black),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  isRepeatingAnimation: true,

                  pause: Duration(milliseconds: 100),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '......',
                      cursor: "",
                      speed: Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      '.....',
                      cursor: "",
                      speed: Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      '....',
                      cursor: "",
                      speed: Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      '...',
                      cursor: "",
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  displayFullTextOnTap: false,
                  stopPauseOnTap: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget chatInput({required ChatController chatController}) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: 40.h),
          decoration: BoxDecoration(
            color: const Color.fromARGB(31, 158, 158, 158),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp),
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null, // 👈 allows infinite lines
            minLines: 1, // 👈 optional: defines the initial height
            controller: chatController.queryController,
            decoration: InputDecoration(
              filled: true,
              hintText: "Ask for Help! ",
              border: InputBorder.none,
              fillColor: Colors.transparent,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      chatController.openCamera();
                    },
                    icon: Icon(CupertinoIcons.camera),
                  ),

                  IconButton(
                    onPressed: () {
                      chatController.pickImageFromGallery();
                    },
                    icon: Image.asset(
                      "assets/icons/home/images.png",
                      height: 25.sp,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                chatController.sendMessage();
              },
              icon: Image.asset("assets/icons/home/send.png", height: 25.sp),
            ),
          ],
        ),
      ],
    );
  }

  static Widget UserChat(String message, {String? imagePath}) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        constraints: BoxConstraints(minWidth: 15.w, maxWidth: 80.w),

        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: const Color.fromARGB(179, 196, 196, 196),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            topRight: Radius.circular(20.sp),

            bottomLeft: Radius.circular(20.sp),
          ),
        ),
        child: Column(
          children: [
            if (imagePath != null) Image.asset(imagePath, height: 20.h),
            Text(textAlign: TextAlign.right, message, style: TextStyle()),
          ],
        ),
      ),
    );
    ;
  }

  static Widget BotChat(String message) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        constraints: BoxConstraints(minWidth: 20),
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: const Color.fromARGB(179, 196, 196, 196),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            topRight: Radius.circular(20.sp),

            bottomRight: Radius.circular(20.sp),
          ),
        ),
        child: MarkdownBody(
          data: message,

          styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
          styleSheet: MarkdownStyleSheet(),
        ),
      ),
    );
  }
}
