import 'dart:ui';
import 'package:flutter/material.dart';

class GlassBackground extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;

  const GlassBackground({
    super.key,
    required this.child,
    this.height = 60,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          // ✨ Glass blur layer
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              height: height,
              width: width,
              color: Color.fromRGBO(255, 255, 255, 0.15),
            ),
          ),

          // 🎯 Foreground content
          Container(
            height: height,
            width: width,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                color: Color.fromRGBO(255, 255, 255, 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(255, 255, 255, 0.06),
                  blurRadius: 30,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
