import 'package:flutter/material.dart';

import '../clippers/coupon_clipper.dart';
import '../painters/coupon_decoration_painter.dart';

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
    this.shadow,
    this.border,
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
  /// Ignored if `decoration` property is used.
  final Color? backgroundColor;

  /// The decoration of the entire widget
  ///
  /// Note: `boxShadow` property in the `BoxDecoration` won't do an effect,
  /// and you should use the `shadow` property of `CouponCard` itself instead.
  final Decoration? decoration;

  /// A shadow applied to the widget.
  ///
  /// Usage
  /// ```dart
  /// CouponCard(
  ///   shadow: BoxShadow(
  ///     color: Colors.black56,
  ///     blurRadius: 10,
  ///   ),
  /// )
  /// ```
  final Shadow? shadow;

  /// A custom border applied to the widget.
  ///
  /// Usage
  /// ```dart
  /// CouponCard(
  ///   border: BorderSide(
  ///     width: 2,
  ///     color: Colors.black,
  ///   ),
  /// )
  /// ```
  final BorderSide? border;

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

    final clipper = CouponClipper(
      borderRadius: borderRadius,
      curveRadius: curveRadius,
      curvePosition: curvePosition,
      curveAxis: curveAxis,
      direction: Directionality.of(context),
      clockwise: clockwise,
    );

    return CustomPaint(
      painter: CouponDecorationPainter(
        shadow: shadow,
        border: border,
        clipper: clipper,
      ),
      child: ClipPath(
        clipper: clipper,
        child: Container(
          width: width,
          height: height,
          decoration: decoration ?? BoxDecoration(color: backgroundColor),
          child: curveAxis == Axis.horizontal
              ? Column(children: children)
              : Row(children: children),
        ),
      ),
    );
  }
}
