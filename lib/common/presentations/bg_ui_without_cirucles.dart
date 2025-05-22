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
            Color.fromARGB(255, 37, 140, 56),
            Color.fromARGB(197, 0, 0, 0),
            Color.fromARGB(210, 3, 8, 136),
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
