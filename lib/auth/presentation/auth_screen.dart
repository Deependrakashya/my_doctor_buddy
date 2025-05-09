import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/presentations/background_ui.dart';
import 'package:my_doctor_buddy/common/widgets/common_widgets.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';
import 'package:my_doctor_buddy/core/services/google_auth.dart';
import 'package:my_doctor_buddy/home.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isAnonymousTapped = false;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: green,
            minimumSize: Size(40, 50),
            shadowColor: Colors.amber,
          ),
        ),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundUi.customBgUi(),
            if (!isloading)
              Positioned(
                top: 20.h,
                width: 100.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Image.asset("assets/illustrations/login.png")],
                ),
              ),
            if (!isloading)
              Positioned(
                bottom: 20.h,
                child: Container(
                  width: 100.w,
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back 👋",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          textBaseline: TextBaseline.alphabetic,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Container(
                        width: 70.w,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Sign in to continue and unlock your full experience.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,

                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (isloading)
              Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 30,
                ),
              ),
          ],
        ),
        bottomSheet:
            isAnonymousTapped
                ? Center(
                  child: AlertDialog.adaptive(
                    backgroundColor: const Color.fromARGB(237, 0, 0, 0),

                    content: Container(
                      height: 50.h,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 10.h),
                          Text(
                            textAlign: TextAlign.center,
                            "You’re signing in as a guest. Your data will be temporarily saved on this device. To secure your account and sync across devices, we recommend creating a full account later.",

                            style: TextStyle(
                              color: const Color.fromARGB(255, 244, 155, 54),
                              fontSize: 15.sp,

                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 30),

                          Column(
                            children: [
                              CommonWidgets.customButton(
                                ontap: () async {
                                  setState(() {
                                    isAnonymousTapped = false;
                                  });
                                },
                                margin: 5,
                                maxHeight: 5,
                                title: "Cancle",
                              ),
                              CommonWidgets.customButton(
                                ontap: () async {
                                  setState(() {
                                    isloading = true;
                                    isAnonymousTapped = false;
                                  });

                                  final userCred =
                                      await AuthService().anonymousLogin();
                                  if (userCred != null) {
                                    setState(() {
                                      isloading = false;
                                      isAnonymousTapped = false;
                                    });
                                    print(
                                      "Logged in as ${userCred.user?.toString()}",
                                    );
                                    Get.offAll(Home());
                                  } else {
                                    setState(() {
                                      isloading = false;
                                    });
                                    print("Anonymous login canceled or failed");
                                  }
                                },
                                title: "Continue",
                                maxHeight: 5,

                                margin: 0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : Container(
                  constraints: BoxConstraints(maxHeight: 20.h),
                  child: Column(
                    children: [
                      CommonWidgets.customButton(
                        ontap: () async {
                          setState(() {
                            isloading = true;
                          });
                          final userCred =
                              await AuthService().signInWithGoogle();
                          if (userCred != null) {
                            Get.offAll(Home());
                            setState(() {
                              isloading = false;
                              isAnonymousTapped = false;
                            });
                            print("Logged in as ${userCred.user?.toString()}");
                          } else {
                            setState(() {
                              isloading = false;
                            });
                            print("Google Sign-In canceled or failed");
                          }
                        },
                        title: "Continue with Google",
                      ),
                      CommonWidgets.customButton(
                        ontap: () async {
                          setState(() {
                            isAnonymousTapped = true;
                          });
                        },
                        title: "Continue Anonymously",
                        margin: 0.h,
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
