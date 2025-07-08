import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonWidgets {
  static customButton({
    required VoidCallback ontap,
    required String title,
    double? maxHeight,
    double? maxWidth,
    double? margin,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: maxHeight?.h ?? 7.h,
          maxWidth: maxWidth?.w ?? 90.w,
        ),
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

  static alertDialog({
    required VoidCallback onSubmit,
    required VoidCallback onCancel,
    required String title,
    required String descritpion,
  }) {
    return AlertDialog(
      title: Text(title),
      titleTextStyle: TextStyle(color: Colors.redAccent, fontSize: 22.sp),
      content: Text(descritpion),
      contentTextStyle: TextStyle(
        color: const Color.fromARGB(255, 227, 185, 13),
      ),

      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll(Colors.grey),
              ),
              onPressed: onCancel,

              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              style: ButtonStyle(
                shadowColor: WidgetStatePropertyAll(Colors.black),
                elevation: WidgetStatePropertyAll(5),
              ),
              onPressed: onSubmit,
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
