import 'dart:math';
import 'package:flutter/material.dart';

class LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.8, size.height * 0.5);
    final paint =
        Paint()
          ..color = const Color.fromARGB(108, 255, 255, 255)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    const int rippleCount = 36;
    const double rippleGap = 40;
    final random = Random();

    for (int i = 1; i <= rippleCount; i++) {
      final radius = i * rippleGap;
      final path = Path();
      Offset? previousPoint;

      for (double angle = 0; angle <= 2 * pi + 0.2; angle += 0.1) {
        // Controlled wave distortion
        final wiggle = sin(angle * 3 + i) * 10;

        final distortedRadius = radius + wiggle;
        final x = center.dx + distortedRadius * cos(angle);
        final y = center.dy + distortedRadius * sin(angle);
        final currentPoint = Offset(x, y);

        if (angle == 0) {
          path.moveTo(x, y);
        } else {
          final cp = Offset(
            (previousPoint!.dx + currentPoint.dx) / 2,
            (previousPoint.dy + currentPoint.dy) / 2,
          );
          path.quadraticBezierTo(cp.dx, cp.dy, x, y);
        }

        previousPoint = currentPoint;
      }

      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
