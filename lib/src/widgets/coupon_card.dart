import 'package:flutter/material.dart';

import '../clippers/coupon_clipper.dart';

/// Provides a coupon card widget
class CouponCard extends StatelessWidget {
  /// Creates a vertical coupon card widget that takes two children
  /// with the properties that defines the shape of the card.
  const CouponCard({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    this.width,
    this.height = 150,
    this.borderRadius = 8,
    this.curveRadius = 20,
    this.curvePosition = 100,
    this.curveAxis = Axis.horizontal,
    this.clockwise = false,
    this.backgroundColor,
    this.decoration,
  }) : super(key: key);

  /// The small child or first.
  final Widget firstChild;

  /// The big child or second.
  final Widget secondChild;

  final double? width;

  final double height;

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

  /// If `false` (by default), then the border radius will be drawn
  /// inside the child, otherwise outside.
  final bool clockwise;

  /// The background color value.
  ///
  /// Ignored if decoration property is used.
  final Color? backgroundColor;

  /// The decoration of the entire widget.
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      if (curveAxis == Axis.horizontal)
        SizedBox(
          width: double.maxFinite,
          height: curvePosition + (curveRadius / 2),
          child: firstChild,
        )
      else
        SizedBox(
          width: curvePosition + (curveRadius / 2),
          height: double.maxFinite,
          child: firstChild,
        ),
      Expanded(child: secondChild),
    ];

    return ClipPath(
      clipper: CouponClipper(
        borderRadius: borderRadius,
        curveRadius: curveRadius,
        curvePosition: curvePosition,
        curveAxis: curveAxis,
        direction: Directionality.of(context),
        clockwise: clockwise,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: decoration ?? BoxDecoration(color: backgroundColor),
        child: curveAxis == Axis.horizontal
            ? Column(children: children)
            : Row(children: children),
      ),
    );
  }
}
