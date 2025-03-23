import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final DateTime time;

  ClockPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final double radius = min(centerX, centerY) - 20;

    // Paint objects
    final Paint paint = Paint()..color = Colors.blue;
    final Paint outlinePaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final Paint centerPaint = Paint()..color = Colors.green;

    final Paint hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    final Paint minHandPaint = Paint()
      ..color = Colors.purple
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    final Paint secHandPaint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    // Draw Clock Circle
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius, outlinePaint);

    // Calculate angles
    final double hourAngle = (time.hour % 12 + time.minute / 60) * 30 * pi / 180;
    final double minuteAngle = time.minute * 6 * pi / 180;
    final double secondAngle = time.second * 6 * pi / 180;

    // Draw hands
    final hourHandEnd = Offset(centerX + radius * 0.5 * cos(hourAngle - pi / 2), centerY + radius * 0.5 * sin(hourAngle - pi / 2));
    final minHandEnd = Offset(centerX + radius * 0.7 * cos(minuteAngle - pi / 2), centerY + radius * 0.7 * sin(minuteAngle - pi / 2));
    final secHandEnd = Offset(centerX + radius * 0.9 * cos(secondAngle - pi / 2), centerY + radius * 0.9 * sin(secondAngle - pi / 2));

    canvas.drawLine(center, hourHandEnd, hourHandPaint);
    canvas.drawLine(center, minHandEnd, minHandPaint);
    canvas.drawLine(center, secHandEnd, secHandPaint);

    // Draw center dot
    canvas.drawCircle(center, 5, centerPaint);
    // Draw tick marks on the outer circle
    for (int i = 0; i < 360; i++) {
      final double angle = (i * 6) * pi / 180; // Convert degrees to radians

      // Start and End Points
      final double outerX = centerX + (radius) * cos(angle);
      final double outerY = centerY + (radius) * sin(angle);
      final double innerX = centerX + (radius - (i % 5 == 0 ? 15 : 8)) * cos(angle);
      final double innerY = centerY + (radius - (i % 5 == 0 ? 15 : 8)) * sin(angle);

      final Paint tickPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = (i % 5 == 0) ? 3 : 1.5;

      // Draw the line
      canvas.drawLine(Offset(outerX, outerY), Offset(innerX, innerY), tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
