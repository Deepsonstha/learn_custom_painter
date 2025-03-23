import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learn_custom_painter/clock/clock_painter.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late DateTime _time;
  late Timer _timer; // Declare Timer

  @override
  void initState() {
    super.initState();
    _time = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _time = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Timer ::$_time");

    return Center(
      child: CustomPaint(
        size: const Size(300, 300),
        painter: ClockPainter(time: _time),
      ),
    );
  }
}
