import 'dart:math';
import 'package:flutter/material.dart';

class LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 1, size.height * 0.4); // ripple origin
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    const int rippleCount = 20;
    const double rippleGap = 40;
    final random = Random();

    for (int i = 1; i <= rippleCount; i++) {
      final radius = i * rippleGap;
      final path = Path();

      Offset? previousPoint;

      for (double angle = 0; angle <= 2 * pi; angle += 0.15) {
        // Dynamic wiggle based on angle and ripple index
        final curveStrength = sin(angle * 3) * 20; // increase to make more wavy
        final wiggle = sin(angle * 4 + i) * curveStrength;

        // Radius with wiggle
        final distortedRadius = radius + wiggle;

        final x = center.dx + distortedRadius * cos(angle);
        final y = center.dy + distortedRadius * sin(angle);
        final currentPoint = Offset(x, y);

        if (angle == 0) {
          path.moveTo(x, y);
        } else {
          // Decide randomly whether to make a corner or a curve
          if (random.nextBool() && previousPoint != null) {
            // Slight corner
            path.lineTo(x, y);
          } else if (previousPoint != null) {
            // Smooth curve using quadratic Bezier
            final controlPoint = Offset(
              (previousPoint.dx + currentPoint.dx) / 2,
              (previousPoint.dy + currentPoint.dy) / 2,
            );
            path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, x, y);
          }
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
