import 'package:flutter/material.dart';

/// A custom painter that draws decorations for coupon cards including
/// shadows, borders.
class CouponDecorationPainter extends CustomPainter {
  /// Creates a painter for coupon card decorations.
  ///
  /// [clipper] is required to determine the shape of the coupon.
  /// [shadow] is optional and draws a shadow around the coupon.
  /// [border] is optional and draws a solid border around the coupon.
  const CouponDecorationPainter({
    this.shadow,
    this.border,
    required this.clipper,
  });

  /// Optional shadow to draw around the coupon.
  final Shadow? shadow;

  /// Optional border to draw around the coupon.
  final BorderSide? border;

  /// The clipper that defines the coupon shape.
  final CustomClipper<Path> clipper;

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
      shadow != oldDelegate.shadow ||
      border != oldDelegate.border ||
      clipper != oldDelegate.clipper;

  @override
  bool shouldRebuildSemantics(CouponDecorationPainter oldDelegate) => false;
}
