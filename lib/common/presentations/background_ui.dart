import 'package:flutter/widgets.dart';
import 'package:my_doctor_buddy/common/presentations/lines_painter.dart';

class BackgroundUi {
  static Widget customBgUi() {
    return Opacity(
      opacity: .6,
      child: Stack(
        children: [
          // 🌊 Radial background glow
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.6, -0.4),
                  radius: .5,
                  colors: [
                    Color(0xFF9EFFC1), // neon mint glow
                    Color(0xFF0A0A23), // fallback base
                  ],
                ),
              ),
            ),
          ),

          // 🌀 Ripple Lines Layer
          Positioned.fill(child: CustomPaint(painter: LinesPainter())),

          // 🎯 Glowing Ball (Bottom Right)
          Positioned(
            top: 170,
            right: -120,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(94, 104, 154, 104),
                    spreadRadius: 10,
                    blurRadius: 70,
                    offset: Offset(-10, -30),
                  ),
                ],
              ),
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.8,
                    colors: [
                      Color(0xFFF3FFE7), // inner mint white glow
                      Color(0xFF8CE497), // green
                      Color(0xFF8CE497).withOpacity(0.5), // fade to transparent
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: .5,
                  colors: [
                    Color(0xFF9EFFC1), // neon mint glow
                    Color(0x000A0A23), // transparent fade to match background
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -200,
            right: 0,
            child: Container(
              width: 800,
              height: 800,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: .5,
                  colors: [
                    Color(0xFF9EFFC1), // neon mint glow
                    Color(0x000A0A23), // transparent fade to match background
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
