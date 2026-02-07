import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavPainter extends CustomPainter {
  final double x;

  NavPainter(this.x);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(x - 60, 0)
      ..quadraticBezierTo(x - 30, 0, x - 30, 30)
      ..arcToPoint(
        Offset(x + 30, 30),
        radius: const Radius.circular(30),
        clockwise: false,
      )
      ..quadraticBezierTo(x + 30, 0, x + 60, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawShadow(path, Colors.black26, 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
