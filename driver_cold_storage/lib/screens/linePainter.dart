import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  DottedLinePainter({required this.color, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.square
      ..strokeWidth = strokeWidth;

    double startY = 0;

    while (startY < size.height) {
      final double endY = startY + 3.0; // Adjust the gap size here
      canvas.drawLine(
          Offset(size.width / 2, startY), Offset(size.width / 2, endY), paint);
      startY += 7.0; // Adjust the gap size + line size here
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
