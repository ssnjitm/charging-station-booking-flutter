import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../config/theme.dart';
import '../../../../shared/models/models.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    // Sample markers
    final sampleStations = [
      ChargingStation(
        id: '1',
        name: 'Kathmandu Central',
        latitude: 27.7172,
        longitude: 85.3240,
        address: 'Thamel, Kathmandu',
        availableSlots: 5,
        totalSlots: 10,
        chargerTypes: ['Fast', 'AC'],
        pricePerKwh: 25.0,
        images: [],
        createdAt: DateTime.now(),
        rating: 4.5,
      ),
      ChargingStation(
        id: '2',
        name: 'Lalitpur Hub',
        latitude: 27.6758,
        longitude: 85.3226,
        address: 'Jawlakhel, Lalitpur',
        availableSlots: 3,
        totalSlots: 8,
        chargerTypes: ['Slow', 'AC'],
        pricePerKwh: 18.0,
        images: [],
        createdAt: DateTime.now(),
        rating: 4.2,
      ),
      ChargingStation(
        id: '3',
        name: 'Bhaktapur Express',
        latitude: 27.6732,
        longitude: 85.4293,
        address: 'Tachapal, Bhaktapur',
        availableSlots: 8,
        totalSlots: 12,
        chargerTypes: ['Fast', 'AC', 'DC'],
        pricePerKwh: 22.0,
        images: [],
        createdAt: DateTime.now(),
        rating: 4.7,
      ),
    ];

    for (final station in sampleStations) {
      _markers.add(
        Marker(
          markerId: MarkerId(station.id),
          position: LatLng(station.latitude, station.longitude),
          infoWindow: InfoWindow(
            title: station.name,
            snippet:
                '${station.availableSlots}/${station.totalSlots} available',
            onTap: () {
              context.push('/station/${station.id}');
            },
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            station.isAvailable
                ? BitmapDescriptor.hueGreen
                : BitmapDescriptor.hueRed,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(27.7172, 85.3240),
          zoom: 12,
        ),
        markers: _markers,
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppTheme.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter Chargers',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: ['Fast', 'Slow', 'AC', 'DC'].map((type) {
                  return FilterChip(
                    label: Text(type),
                    onSelected: (selected) {},
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text('Apply')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
