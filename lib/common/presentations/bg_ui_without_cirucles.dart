import 'package:flutter/material.dart';
import 'package:my_doctor_buddy/common/presentations/lines_painter.dart';

class BgUiWithoutCirucles extends StatelessWidget {
  const BgUiWithoutCirucles({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 47, 77, 53),
            Color.fromARGB(133, 45, 64, 106),
            Color.fromARGB(255, 138, 108, 183),
          ],
        ),
      ),
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: LinesPainter(),
      ),
    );
  }
}
