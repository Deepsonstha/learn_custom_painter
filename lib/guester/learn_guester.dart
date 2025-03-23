import 'package:flutter/material.dart';

class LearnGuester extends StatefulWidget {
  const LearnGuester({super.key});

  @override
  State<LearnGuester> createState() => _LearnGuesterState();
}

class _LearnGuesterState extends State<LearnGuester> {
  List<Offset> touchPoints = [];
  List<List<Offset>> history = []; // Stores previous states
  List<List<Offset>> redoHistory = []; // Stores undone states for redo

  void _saveToHistory() {
    history.add(List.from(touchPoints)); // Save current state
    redoHistory.clear(); // Clear redo stack on new changes
  }

  void _undo() {
    if (history.isNotEmpty) {
      redoHistory.add(List.from(touchPoints)); // Save for redo
      setState(() {
        touchPoints = history.removeLast(); // Restore last state
      });
    }
  }

  void _redo() {
    if (redoHistory.isNotEmpty) {
      history.add(List.from(touchPoints)); // Save current before redo
      setState(() {
        touchPoints = redoHistory.removeLast(); // Restore last undone state
      });
    }
  }

  void _clear() {
    _saveToHistory();
    setState(() {
      touchPoints.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onPanUpdate: (details) {
                _saveToHistory();
                setState(() {
                  touchPoints.add(details.localPosition);
                });
              },
              onTapDown: (details) {
                _saveToHistory();
                setState(() {
                  touchPoints.add(details.localPosition);
                });
              },
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    height: 500,
                    width: 500,
                    child: Stack(
                      children: touchPoints
                          .map((offset) => Positioned(
                                left: offset.dx,
                                top: offset.dy,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _undo,
                          icon: const Icon(Icons.undo),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: _redo,
                          icon: const Icon(Icons.redo),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: _clear,
                          child: const Text("CLEAR"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
