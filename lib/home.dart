import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/common/presentations/background_ui.dart';
import 'package:my_doctor_buddy/core/const_colors.dart';
import 'package:sizer/sizer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for glowing backgrounds and shadows
      body: Stack(children: [BackgroundUi.customBgUi()]),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromARGB(255, 200, 255, 217),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.transparent,
        height: 50,
        items: _iconList,
      ),
    );
  }
}
