import 'dart:math';

import 'package:flutter/material.dart';

class UVIndexPainter extends CustomPainter {
  final double index;

  UVIndexPainter(this.index);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..moveTo(20, size.height - 20)
      // ..arcToPoint(Offset(arcWidth / 2, arcHeight / 4),
      //     radius: const Radius.circular(85));
      ..arcTo(
          Rect.fromPoints(
              const Offset(18, 30), Offset(size.width - 18, size.height + 50)),
          pi,
          (index / 15) * pi,
          true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
