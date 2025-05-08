import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonWidgets {
  static customButton({
    required VoidCallback ontap,
    required String title,
    double? margin,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        constraints: BoxConstraints(maxHeight: 7.h, maxWidth: 90.w),
        margin: EdgeInsets.symmetric(vertical: margin ?? 2.h),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(184, 41, 49, 36),
              offset: Offset(3, 6),
              spreadRadius: 3,
              blurRadius: 2,
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
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w900,
            fontSize: 17.sp,
          ),
        ),
      ),
    );
  }
}
