import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Draw a rectangle
    canvas.drawRect(
      const Rect.fromLTWH(40, 40, 80, 80),
      paint,
    );

    // Draw a circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      50,
      paint..color = Colors.red,
    );
    TextPainter textPainter = TextPainter(
      text: const TextSpan(text: "(10,50)", style: TextStyle(color: Colors.white, fontSize: 20)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width / 2, size.height / 2));
    canvas.drawLine(const Offset(10, 200), const Offset(400, 200), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
