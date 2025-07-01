import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DashoardWidgets {
  static Widget customTiles({
    required text,
    VoidCallback? func,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: func,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(184, 41, 49, 36),
              offset: Offset(3, 6),
              spreadRadius: 3,
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(15.sp),
          gradient: LinearGradient(
            colors: [Color(0xffE0FE52), Color(0xff8BE595)],
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 5.w,
          children: [
            Icon(icon, color: Colors.black),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Shows "..." on overflow
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static customButton({
    required VoidCallback ontap,
    required String title,
    double? margin,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
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
