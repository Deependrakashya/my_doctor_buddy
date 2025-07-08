import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/viewModel/chat_controller.dart';
import 'package:my_doctor_buddy/views/common/glass_background.dart';
import 'package:sizer/sizer.dart';

class ChatWidgets {
  static Widget customChatAppBar({
    required String title,
    String? descritption,
  }) {
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
                title,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20.sp,
                ),
              ),
              Text(descritption ?? ""),
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
    return ChatBG(
      alignment: Alignment.topRight,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            if (imagePath != null) Image.asset(imagePath, height: 20.h),
            Text(
              textAlign: TextAlign.right,
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: .9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget BotChat(String message) {
    return ChatBG(
      alignment: Alignment.topLeft,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          // margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          constraints: BoxConstraints(minWidth: 20),
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: MarkdownBody(
            data: message,
            styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                fontSize: 16.sp,
                height: 1.6, // better line spacing
              ),
              strong: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w900,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.185),
                letterSpacing: 0,

                fontSize: 18.sp,
              ),
              em: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
              code: TextStyle(
                color: Colors.black,
                fontFamily: 'Albert_Sans',
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.transparent,
              ),
              blockquote: TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
              listBullet: TextStyle(
                color: Colors.white.withOpacity(0.9),

                fontSize: 21.sp,
              ),
              a: TextStyle(
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget ChatBG({
    required Widget child,
    required BorderRadiusGeometry borderRadius,
    required AlignmentGeometry alignment,
  }) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 95.w), // Max width cap
        child: IntrinsicWidth(
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(color: Colors.white.withOpacity(0.15)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 1.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.06),
                        blurRadius: 30,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
