import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/widgets/common_widgets.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';
import 'package:my_doctor_buddy/core/services/account_service.dart.dart';
import 'package:my_doctor_buddy/core/services/google_auth.dart';
import 'package:my_doctor_buddy/core/services/onboarding_service.dart';
import 'package:my_doctor_buddy/dashboard/presentation/dashboard_controller.dart';
import 'package:my_doctor_buddy/dashboard/presentation/dashoard_widgets/dashoard_widgets.dart';
import 'package:my_doctor_buddy/onboarding/domain/controller/onboarding_controller.dart';
import 'package:my_doctor_buddy/onboarding/presentation/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final DashboardController dashboardController = DashboardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return dashboardController.isLoading.value
                ? Container(
                  height: 90.h,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 30.sp,
                      color: Colors.white,
                    ),
                  ),
                )
                : Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    spacing: 3.h,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        maxRadius: 30.sp,
                        backgroundColor: Colors.amber,
                        backgroundImage: NetworkImage(
                          AccountService.currentUserPhotoUrl,
                        ),
                      ),

                      Text(
                        AccountService.currentUserName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        spacing: 2.h,
                        children: [
                          DashoardWidgets.customTiles(
                            icon: Icons.person_2_rounded,
                            text: AccountService.currentUserName,
                          ),
                          DashoardWidgets.customTiles(
                            icon: Icons.email_sharp,
                            text: AccountService.currentUserEmail,
                          ),
                          DashoardWidgets.customTiles(
                            icon: CupertinoIcons.arrow_right,
                            text: "Switch to Google Sign-Up",
                            func: () {
                              dashboardController.switchToGoogleSignUp();
                            },
                          ),
                          DashoardWidgets.customTiles(
                            icon: Icons.logout,
                            text: "log Out",
                            func: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: const Color.fromARGB(
                                    209,
                                    2,
                                    2,
                                    2,
                                  ),
                                  child: Container(
                                    height: 30.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5.h),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            "Are you Sure to Log out Your Account",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: red,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.sp,
                                              ),
                                              child:
                                                  DashoardWidgets.customButton(
                                                    ontap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    title: "Cancle",
                                                    margin: 0,
                                                  ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 10.sp,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.sp,
                                              ),
                                              child:
                                                  DashoardWidgets.customButton(
                                                    ontap: () {
                                                      Navigator.pop(context);
                                                      dashboardController
                                                          .logOut();
                                                    },
                                                    title: "Log Out",
                                                    margin: 0,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
          }),
        ),
      ),
    );
  }
}
