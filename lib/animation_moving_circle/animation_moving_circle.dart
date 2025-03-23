import 'package:flutter/material.dart';
import 'package:learn_custom_painter/animation_moving_circle/moving_circle_painter.dart';

class AnimationMovingCircle extends StatefulWidget {
  const AnimationMovingCircle({super.key});

  @override
  State<AnimationMovingCircle> createState() => _AnimationMovingCircleState();
}

class _AnimationMovingCircleState extends State<AnimationMovingCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = Tween<Offset>(begin: const Offset(30, 100), end: const Offset(400, 100)).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(100, 100),
          painter: MovingCirclePainter(offsetPosition: _animation.value),
        );
      },
    );
  }
}
