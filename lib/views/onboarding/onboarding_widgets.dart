import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/core/const_style.dart';
import 'package:sizer/sizer.dart';

class OnboardingWidgets {
  static Widget customPage({
    required String imgUrl,
    required String heading,
    required String subHeading,
  }) {
    return Container(
      color: Color.fromRGBO(34, 28, 28, 0.116),
      padding: EdgeInsets.symmetric(horizontal: .15.dp),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 2.h,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image
              Image.asset(imgUrl),
              //text
              Text(
                textAlign: TextAlign.center,
                heading,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                subHeading,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
