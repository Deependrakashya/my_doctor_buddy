import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:my_doctor_buddy/common/widgets/common_widgets.dart';
import 'package:my_doctor_buddy/views/chat/chat_widgets.dart';
import 'package:my_doctor_buddy/views/chat/doctor_buddy_widgets.dart';
import 'package:my_doctor_buddy/views/common/glass_background.dart';
import 'package:my_doctor_buddy/views/tips&feeds/tip_feed_details.dart';
import 'package:sizer/sizer.dart';

class TipsFeedScreen extends StatelessWidget {
  const TipsFeedScreen({super.key});
  Future<List<Map<String, dynamic>>> fetchData() async {
    final snapshot = await FirebaseFirestore.instance.collection('blogs').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ChatWidgets.customChatAppBar(title: "Health Blogs"),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(color: Colors.white),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final data = snapshot.data;

                  if (data == null || data.isEmpty) {
                    return const Center(child: Text("No data found"));
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder:
                                  (context) => TipFeedDetails(
                                    title: item['title'],
                                    des: item['blog'],
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10.sp,
                            horizontal: 10.sp,
                          ),
                          child: GlassBackground(
                            height: 60,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              height: 100, // or whatever fits your design
                              child: SingleChildScrollView(
                                child: MarkdownBody(
                                  data: item['title'] ?? '',
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
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
