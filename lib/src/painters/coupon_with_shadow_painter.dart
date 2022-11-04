import 'package:flutter/material.dart';

class CouponWithShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  CouponWithShadowPainter({
    required this.shadow,
    required this.clipper,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = shadow.toPaint();
    final path = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CouponWithShadowPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CouponWithShadowPainter oldDelegate) => false;
}
