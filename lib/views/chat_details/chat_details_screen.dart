import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/common/screens/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/views/chat/chat_widgets.dart';
import 'package:sizer/sizer.dart';

class ChatDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> chatData; // Single chat with title, messages...

  const ChatDetailsScreen({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
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
                child: Column(
                  children: [
                    ChatWidgets.customChatAppBar(
                      title: chatData['title'] ?? 'Chat',
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ChatWidgets.UserChat(chatData['title']),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ChatWidgets.BotChat(chatData['lastMessage']),
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
