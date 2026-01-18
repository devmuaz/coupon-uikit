import 'package:flutter/material.dart';

import 'coupon_examples.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coupon UI Kit Showcase'), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Basic Coupon Cards'),
          const SizedBox(height: 8),
          const BasicCouponExample(),
          const SizedBox(height: 24),
          _buildSectionHeader('Basic Coupon Cards 2'),
          const SizedBox(height: 8),
          const BasicCouponExample2(),
          const SizedBox(height: 24),
          _buildSectionHeader('Rounded Coupon Cards'),
          const SizedBox(height: 8),
          const RoundedCouponExample(),
          const SizedBox(height: 24),
          _buildSectionHeader('Bordered Coupon Cards'),
          const SizedBox(height: 8),
          const BorderedCouponExample(),
          const SizedBox(height: 24),
          _buildSectionHeader('Vertical Coupon Cards'),
          const SizedBox(height: 8),
          const VerticalCouponExample(),
          const SizedBox(height: 24),
          _buildSectionHeader('Gradient Coupon Cards'),
          const SizedBox(height: 8),
          const GradientCouponExample(),
          const SizedBox(height: 24),
          _buildSectionHeader('Custom Styled Coupons'),
          const SizedBox(height: 8),
          const CustomStyledCouponExample(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
