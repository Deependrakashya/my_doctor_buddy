import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:my_doctor_buddy/common/screens/background_ui.dart';
import 'package:my_doctor_buddy/common/screens/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/views/chat/chat_widgets.dart';
import 'package:my_doctor_buddy/views/common/glass_background.dart';
import 'package:sizer/sizer.dart';

class TipFeedDetails extends StatelessWidget {
  final String title;
  final String des;

  TipFeedDetails({super.key, required this.title, required this.des});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BgUiWithoutCirucles(),

            /// Entire scrollable content
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90.w,
                  height: 10.h,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: Markdown(
                          data: title,
                          styleSheetTheme:
                              MarkdownStyleSheetBaseTheme.cupertino,
                          styleSheet: MarkdownStyleSheet(
                            h1: TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                GlassBackground(
                  height: 80.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title with max height
                        Container(
                          constraints: BoxConstraints(maxHeight: 80),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: MarkdownBody(
                              data: title,
                              styleSheetTheme:
                                  MarkdownStyleSheetBaseTheme.cupertino,
                              styleSheet: MarkdownStyleSheet(
                                h1: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// Full markdown content
                        MarkdownBody(
                          data: des,
                          styleSheetTheme:
                              MarkdownStyleSheetBaseTheme.cupertino,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                              color: Colors.black,
                              backgroundColor: Colors.transparent,
                              fontSize: 17.sp,
                              height: 1.6,
                            ),
                            strong: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              backgroundColor: const Color.fromRGBO(
                                0,
                                0,
                                0,
                                0.185,
                              ),
                              fontSize: 18.sp,
                            ),
                            em: const TextStyle(
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                            code: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Albert_Sans',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              backgroundColor: Colors.transparent,
                            ),
                            blockquote: const TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),

                            listBullet: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 21.sp,
                            ),
                            a: const TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
