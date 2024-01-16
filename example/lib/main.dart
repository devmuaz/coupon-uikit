import 'package:flutter/material.dart';

import 'samples/horizontal_coupon_example_1.dart';
import 'samples/horizontal_coupon_example_2.dart';
import 'samples/vertical_coupon_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coupon Cards Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coupon Cards Demo')),
      body: const Padding(
        padding: EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HorizontalCouponExample1(),
              SizedBox(height: 14),
              VerticalCouponExample(),
              SizedBox(height: 14),
              HorizontalCouponExample2(),
            ],
          ),
        ),
      ),
    );
  }
}
