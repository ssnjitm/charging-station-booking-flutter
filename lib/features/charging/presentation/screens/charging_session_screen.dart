import 'package:flutter/material.dart';

class ChargingSessionScreen extends StatelessWidget {
  final String? stationId;
  const ChargingSessionScreen({Key? key, this.stationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Charging Session')),
      body: const Center(child: Text('Charging Session Screen')),
    );
  }
}
