import 'package:flutter/material.dart';

/// Clips a widget to the form of a coupon card shape
class CouponClipper extends CustomClipper<Path> {
  /// Paints a coupon shape around any widget.
  ///
  /// Usage:
  /// ```dart
  /// ClipPath(
  ///   clipper: CouponClipper(
  ///     // optional (defaults to TextDirection.ltr), works when
  ///     // curveAxis set to Axis.vertical
  ///     direction: Directionality.of(context),
  ///   ),
  ///   // width and height are important depending on the type
  ///   // of the text direction
  ///   child: Container(
  ///     width: 350,
  ///     height: 400,
  ///     color: Colors.purple,
  ///   ),
  /// ),
  /// ```
  const CouponClipper({
    this.borderRadius = 8,
    this.curveRadius = 20,
    this.curvePosition = 100,
    this.curveAxis = Axis.horizontal,
    this.direction = TextDirection.ltr,
    this.clockwise = false,
  }) : assert(
          curvePosition > borderRadius,
          "'curvePosition' should be greater than the 'borderRadius'",
        );

  /// Border radius value.
  final double borderRadius;

  /// The curve radius value, which specifies its size.
  final double curveRadius;

  /// The curve position, which specifies the curve position depending
  /// on the its child's size.
  final double curvePosition;

  /// The direction of the curve, whether it's set vertically or
  /// horizontally.
  final Axis curveAxis;

  /// If `curveAxis` set to `Axis.vertical`, then direction is useful
  /// for languages like (Ar, Fa, ...).
  final TextDirection direction;

  /// If `false` (by default), then the border radius will be drawn
  /// inside the child, otherwise outside.
  final bool clockwise;

  @override
  Path getClip(Size size) {
    double directionalCurvePosition = curvePosition;

    if (curveAxis == Axis.vertical && direction == TextDirection.rtl) {
      directionalCurvePosition = size.width - curvePosition - curveRadius;
    }

    final Radius arcRadius = Radius.circular(borderRadius);

    // border radius arc points
    final Offset bottomLeftArc = Offset(borderRadius, size.height);
    final Offset bottomRightArc =
        Offset(size.width, size.height - borderRadius);
    final Offset topRightArc = Offset(size.width - borderRadius, 0);
    final Offset topLeftArc = Offset(0, borderRadius);

    final Path path = Path();

    // starting point
    path.moveTo(0, borderRadius - 2);

    // left curve
    if (curveAxis == Axis.horizontal) {
      path.lineTo(0, directionalCurvePosition);
      path.quadraticBezierTo(
        curveRadius / 1.5,
        directionalCurvePosition + (curveRadius / 2),
        0,
        directionalCurvePosition + curveRadius,
      );
    }

    // left line, bottom left arc
    path.lineTo(0, size.height - borderRadius);
    path.arcToPoint(bottomLeftArc, radius: arcRadius, clockwise: clockwise);

    // bottom cuve
    if (curveAxis == Axis.vertical) {
      path.lineTo(directionalCurvePosition, size.height);
      path.quadraticBezierTo(
        directionalCurvePosition + (curveRadius / 2),
        size.height - (curveRadius / 1.5),
        directionalCurvePosition + curveRadius,
        size.height,
      );
    }

    // bottom line, bottom right arc
    path.lineTo(size.width - borderRadius, size.height);
    path.arcToPoint(bottomRightArc, radius: arcRadius, clockwise: clockwise);

    // right curve
    if (curveAxis == Axis.horizontal) {
      path.lineTo(size.width, directionalCurvePosition + curveRadius);
      path.quadraticBezierTo(
        size.width - (curveRadius / 1.5),
        directionalCurvePosition + (curveRadius / 2),
        size.width,
        directionalCurvePosition,
      );
    }

    // right line, top right arc
    path.lineTo(size.width, borderRadius);
    path.arcToPoint(topRightArc, radius: arcRadius, clockwise: clockwise);

    // top curve
    if (curveAxis == Axis.vertical) {
      path.lineTo(directionalCurvePosition + curveRadius, 0);
      path.quadraticBezierTo(
        (directionalCurvePosition - (curveRadius / 2)) + curveRadius,
        curveRadius / 1.5,
        directionalCurvePosition - curveRadius + curveRadius,
        0,
      );
    }

    // top line, top left arc
    path.lineTo(borderRadius, 0);
    path.arcToPoint(topLeftArc, radius: arcRadius, clockwise: clockwise);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}
