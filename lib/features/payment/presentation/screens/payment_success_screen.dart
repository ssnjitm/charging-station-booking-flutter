import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String transactionId;
  const PaymentSuccessScreen({Key? key, required this.transactionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Success')),
      body: Center(
        child: Text('Transaction ID: $transactionId'),
      ),
    );
  }
}
