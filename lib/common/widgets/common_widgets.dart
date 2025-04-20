import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonWidgets {
  static customButton({required VoidCallback ontap, required String title}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        constraints: BoxConstraints(maxHeight: 7.h, maxWidth: 90.w),
        margin: EdgeInsets.symmetric(vertical: 2.h),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 20,
              offset: Offset(-5, -5),
            ),
          ],
          borderRadius: BorderRadius.circular(30.dp),
          gradient: LinearGradient(
            colors: [Color(0xffE0FE52), Color(0xff8BE595)],
          ),
        ),
        alignment: Alignment.center,

        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
