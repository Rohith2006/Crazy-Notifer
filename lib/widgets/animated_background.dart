import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: GradientBackgroundPainter(_controller.value),
          );
        },
      ),
    );
  }
}

class GradientBackgroundPainter extends CustomPainter {
  final double animationValue;

  GradientBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Create a linear gradient with animated color stops
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue.withOpacity(0.5),
        Colors.purple.withOpacity(0.5),
      ],
      stops: [
        (0.5 + 0.5 * math.sin(animationValue * math.pi * 2)) % 1.0,
        (0.5 + 0.5 * math.cos(animationValue * math.pi * 2)) % 1.0,
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw a rectangle with the gradient
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}