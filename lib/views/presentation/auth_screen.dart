import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/screens/background_ui.dart';
import 'package:my_doctor_buddy/common/widgets/common_widgets.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';
import 'package:my_doctor_buddy/services/google_auth.dart';
import 'package:my_doctor_buddy/views/home.dart';
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
                ? AlertDialog(
                  title: const Text("Attention!!"),
                  titleTextStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 22.sp,
                  ),
                  content: Text(
                    "You’re signing in as a guest. Your data will be temporarily saved on this device. To secure your account and sync across devices, we recommend creating a full account later.",
                  ),
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
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.grey,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isAnonymousTapped = false;
                            });
                          },

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
                          onPressed: () async {
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
                )
                : Container(
                  constraints: BoxConstraints(maxHeight: 20.h),
                  child: Column(
                    children: [
                      CommonWidgets.customButton(
                        ontap: () async {
                          HapticFeedback.mediumImpact();
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
                          HapticFeedback.mediumImpact();

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
