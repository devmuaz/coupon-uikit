import 'package:flutter/material.dart';

class CouponDecorationPainter extends CustomPainter {
  final Shadow? shadow;
  final BorderSide? border;
  final CustomClipper<Path> clipper;

  CouponDecorationPainter({
    this.shadow,
    this.border,
    required this.clipper,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (shadow != null) {
      final paintShadow = shadow!.toPaint();
      final pathShadow = clipper.getClip(size).shift(shadow!.offset);
      canvas.drawPath(pathShadow, paintShadow);
    }

    if (border != null) {
      final paintBorder = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = border!.width
        ..color = border!.color;
      final pathBorder = clipper.getClip(size);
      canvas.drawPath(pathBorder, paintBorder);
    }
  }

  @override
  bool shouldRepaint(CouponDecorationPainter oldDelegate) =>
      this != oldDelegate;

  @override
  bool shouldRebuildSemantics(CouponDecorationPainter oldDelegate) =>
      this != oldDelegate;
}
