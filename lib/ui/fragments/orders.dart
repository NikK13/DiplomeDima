import 'package:flutter/material.dart';

class OrdersFragment extends StatelessWidget {
  const OrdersFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "ORDERS"
          ),
        ),
      ),
    );
  }
}