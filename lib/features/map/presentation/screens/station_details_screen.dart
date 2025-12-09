import 'package:flutter/material.dart';

class StationDetailsScreen extends StatelessWidget {
  final String stationId;
  const StationDetailsScreen({Key? key, required this.stationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Station Details')),
      body: const Center(child: Text('Station Details Screen')),
    );
  }
}
