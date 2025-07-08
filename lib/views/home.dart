import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/common/screens/background_ui.dart';
import 'package:my_doctor_buddy/common/screens/bg_ui_without_cirucles.dart';
import 'package:my_doctor_buddy/services/account_service.dart.dart';
import 'package:my_doctor_buddy/views/common/glass_background.dart';
import 'package:my_doctor_buddy/views/dashboard/dashboard_screen.dart';
import 'package:my_doctor_buddy/views/chat/doctor_buddy_screen.dart';
import 'package:my_doctor_buddy/views/tips&feeds/tips_feed_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _activeIndex = 1;

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
        children: [
          AccountService.currentUserName.isNotEmpty
              ? BgUiWithoutCirucles()
              : BackgroundUi.customBgUi(),
          _screenList[_activeIndex],
        ],
      ),
      bottomNavigationBar: GlassBackground(
        padding: EdgeInsets.all(0),
        child: CurvedNavigationBar(
          // color: Color.fromARGB(255, 200, 255, 217),
          color: Colors.transparent,
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
      ),
    );
  }
}
