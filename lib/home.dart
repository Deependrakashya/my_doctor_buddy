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
    Icon(Icons.home, color: Colors.white),
    Icon(Icons.chat, color: Colors.white),
    Icon(Icons.man, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for glowing backgrounds and shadows
      body: Stack(
        children: [
          BackgroundUi.customBgUi(), // 💫 Custom background layer
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: green,
        backgroundColor: transparentFade,
        buttonBackgroundColor: Colors.amberAccent,
        height: 50,
        items: _iconList,
      ),
    );
  }
}
