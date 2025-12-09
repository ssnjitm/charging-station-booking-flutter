import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final double amount;
  const PaymentScreen({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Center(
        child: Text('Payment Screen - Amount: Rs. ${amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
