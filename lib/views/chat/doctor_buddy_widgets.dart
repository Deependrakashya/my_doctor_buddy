import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/views/common/glass_background.dart';
import 'package:sizer/sizer.dart';

class DoctorBuddyWidgets {
  Widget ChatListTile({required String title, required VoidCallback ontap}) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(17.sp),
      splashColor: const Color.fromARGB(185, 255, 255, 255),
      child: GlassBackground(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 4.w),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  "assets/icons/home/AiIcon.png",
                  height: 28.sp,
                ),
              ),
            ),
            SizedBox(
              width: 60.w,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget NewChatButton({required VoidCallback ontap}) {
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
        child: Text("Ask Something", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
