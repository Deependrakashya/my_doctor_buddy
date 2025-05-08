import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/common/presentations/background_ui.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';
import 'package:my_doctor_buddy/core/services/google_auth.dart';
import 'package:my_doctor_buddy/core/services/onboarding_service.dart';
import 'package:my_doctor_buddy/dashboard/presentation/dashboard_screen.dart';
import 'package:my_doctor_buddy/doctor_buddy/presentation/doctor_buddy.dart';
import 'package:my_doctor_buddy/onboarding/presentation/onboarding_screen.dart';
import 'package:my_doctor_buddy/tips_&_feed/presentation/tips_feed_screen.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _activeIndex = 2;

  final _iconList = <Widget>[
    Image.asset('assets/icons/home/tips.gif', height: 40, width: 40),
    Image.asset('assets/icons/home/chat.gif', height: 40, width: 40),
    Image.asset('assets/icons/home/profile.gif', height: 40, width: 40),
  ];
  final _screenList = <Widget>[
    TipsFeedScreen(),
    DoctorBuddyScreen(),
    DashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for glowing backgrounds and shadows
      body: Stack(
        children: [BackgroundUi.customBgUi(), _screenList[_activeIndex]],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromARGB(255, 200, 255, 217),
        onTap:
            (value) => setState(() {
              _activeIndex = value;
            }),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.transparent,
        height: 50,
        index: _activeIndex,
        items: _iconList,
      ),
    );
  }
}
