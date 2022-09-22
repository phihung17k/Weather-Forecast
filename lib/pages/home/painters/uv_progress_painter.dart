import 'dart:math';
import 'package:flutter/material.dart';

class UVProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color.fromARGB(255, 235, 225, 225)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    //1 radian = 180 / pi;

    var path = Path()
      ..moveTo(0, size.height)
      // ..arcToPoint(Offset(arcWidth, arcHeight),
      //     radius: const Radius.circular(85));
      ..arcTo(
          Rect.fromPoints(
              const Offset(18, 30), Offset(size.width - 18, size.height + 50)),
          pi,
          pi,
          true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
