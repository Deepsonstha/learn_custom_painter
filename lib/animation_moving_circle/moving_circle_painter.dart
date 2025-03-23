import 'package:flutter/material.dart';

class MovingCirclePainter extends CustomPainter {
  final Offset offsetPosition;

  MovingCirclePainter({required this.offsetPosition});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Paint linePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;
    canvas.drawLine(const Offset(30, 100), const Offset(400, 100), linePaint);
    canvas.drawCircle(offsetPosition, 10, paint);
  }

  @override
  bool shouldRepaint(covariant MovingCirclePainter oldDelegate) {
    return oldDelegate.offsetPosition != offsetPosition;
  }
}
