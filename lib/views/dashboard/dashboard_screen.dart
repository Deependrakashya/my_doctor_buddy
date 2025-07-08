import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/common/widgets/common_widgets.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';
import 'package:my_doctor_buddy/services/account_service.dart.dart';
import 'package:my_doctor_buddy/services/google_auth.dart';
import 'package:my_doctor_buddy/services/onboarding_service.dart';
import 'package:my_doctor_buddy/viewModel/dashboard_controller.dart';
import 'package:my_doctor_buddy/views/dashboard/dashoard_widgets.dart';
import 'package:my_doctor_buddy/viewModel/onboarding_controller.dart';
import 'package:my_doctor_buddy/views/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final DashboardController dashboardController = Get.put(
    DashboardController(),
  );

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
                          if (AccountService.currentUserName == 'Anonymous')
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
                                CommonWidgets.alertDialog(
                                  title: "Logout",
                                  descritpion: "Are you sure to Log Out",
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                  onSubmit: () {
                                    Navigator.pop(context);
                                    dashboardController.logOut();
                                  },
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
