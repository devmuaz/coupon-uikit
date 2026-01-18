import 'package:flutter/material.dart';

import '../clippers/coupon_clipper.dart';
import '../painters/coupon_decoration_painter.dart';

/// A widget that displays a coupon card with two sections separated by
/// a curved cutout.
///
/// The coupon card consists of two children: [firstChild] and [secondChild],
/// which are separated by a curved cutout. The card can be oriented
/// horizontally or vertically using [curveAxis].
///
/// Example:
/// ```dart
/// CouponCard(
///   height: 150,
///   backgroundColor: Colors.blue,
///   firstChild: Container(color: Colors.red, child: Text('23% OFF')),
///   secondChild: Container(padding: EdgeInsets.all(16), child: Text('Coupon Code')),
/// )
/// ```
class CouponCard extends StatelessWidget {
  /// Creates a coupon card widget that takes two children
  /// with the properties that defines the shape of the card.
  const CouponCard({
    super.key,
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
  });

  /// The small child or first section of the coupon card.
  final Widget firstChild;

  /// The big child or second section of the coupon card.
  final Widget secondChild;

  /// The width of the coupon card.
  ///
  /// If null, the card will take the full width of its parent.
  final double? width;

  /// The height of the coupon card.
  final double height;

  /// Border radius value for the corners of the coupon card.
  final double borderRadius;

  /// The curve radius value, which specifies the size of the cutout curve.
  final double curveRadius;

  /// The curve position, which specifies where the curve is positioned
  /// depending on the child's size.
  final double curvePosition;

  /// The direction of the curve, whether it's set vertically or horizontally.
  ///
  /// - [Axis.horizontal]: The curve cuts horizontally, separating top and bottom sections.
  /// - [Axis.vertical]: The curve cuts vertically, separating left and right sections.
  final Axis curveAxis;

  /// If `false` (by default), then the border radius will be drawn
  /// inside the child, otherwise outside.
  final bool clockwise;

  /// The background color value.
  ///
  /// Ignored if [decoration] property is used.
  final Color? backgroundColor;

  /// The decoration of the entire widget.
  ///
  /// Note: `boxShadow` property in the `BoxDecoration` won't have an effect,
  /// and you should use the [shadow] property of `CouponCard` itself instead.
  final Decoration? decoration;

  /// A shadow applied to the widget.
  ///
  /// Example:
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
  /// Example:
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
