import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/lines_painter.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BackgroundOnlyScreen(),
    ),
  );
}

class BackgroundOnlyScreen extends StatelessWidget {
  const BackgroundOnlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A23), // deep navy base
      body: Stack(
        children: [
          // 🎯 Radial Gradient Glow
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.6, -0.3),
                  radius: 1.2,
                  colors: [
                    Color(0xFF9EFFC1), // neon mint glow
                    Color(0xFF0A0A23), // fallback base
                  ],
                ),
              ),
            ),
          ),

          // 🌀 Another glowing blob (bottom left)
          Positioned(
            bottom: 80,
            left: 30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00FFB8).withOpacity(0.8),
                    const Color(0xFF0A0A23),
                  ],
                ),
              ),
            ),
          ),

          // ✅ Optional: Layer for contour lines (currently just placeholder with transparent lines)
          Positioned.fill(child: CustomPaint(painter: LinesPainter())),
        ],
      ),
    );
  }
}
