import '../models/models.dart';

class DummyData {
  static List<ChargingStation> sampleStations = [
    ChargingStation(
      id: '1',
      name: 'Kathmandu Central Hub',
      latitude: 27.7172,
      longitude: 85.3240,
      address: 'Thamel, Kathmandu',
      availableSlots: 5,
      totalSlots: 10,
      chargerTypes: ['Fast', 'AC'],
      pricePerKwh: 25.0,
      images: [],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      rating: 4.5,
    ),
    ChargingStation(
      id: '2',
      name: 'Lalitpur Modern Charging',
      latitude: 27.6758,
      longitude: 85.3226,
      address: 'Jawlakhel, Lalitpur',
      availableSlots: 3,
      totalSlots: 8,
      chargerTypes: ['Slow', 'AC'],
      pricePerKwh: 18.0,
      images: [],
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      rating: 4.2,
    ),
    ChargingStation(
      id: '3',
      name: 'Bhaktapur Express Station',
      latitude: 27.6732,
      longitude: 85.4293,
      address: 'Tachapal, Bhaktapur',
      availableSlots: 8,
      totalSlots: 12,
      chargerTypes: ['Fast', 'AC', 'DC'],
      pricePerKwh: 22.0,
      images: [],
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      rating: 4.7,
    ),
    ChargingStation(
      id: '4',
      name: 'Patan EV Hub',
      latitude: 27.6584,
      longitude: 85.3216,
      address: 'Mangal Bazaar, Patan',
      availableSlots: 2,
      totalSlots: 6,
      chargerTypes: ['Slow'],
      pricePerKwh: 15.0,
      images: [],
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      rating: 4.0,
    ),
    ChargingStation(
      id: '5',
      name: 'Boudha Charging Point',
      latitude: 27.7206,
      longitude: 85.3639,
      address: 'Boudha, Kathmandu',
      availableSlots: 10,
      totalSlots: 15,
      chargerTypes: ['Fast', 'AC', 'DC'],
      pricePerKwh: 26.0,
      images: [],
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      rating: 4.8,
    ),
  ];

  static List<ChargingSession> sampleSessions = [
    ChargingSession(
      id: '1',
      userId: 'user-1',
      stationId: '1',
      startTime: DateTime.now().subtract(const Duration(hours: 2)),
      endTime: DateTime.now().subtract(const Duration(hours: 1)),
      kwhConsumed: 15.5,
      totalPrice: 387.5,
      status: 'completed',
    ),
    ChargingSession(
      id: '2',
      userId: 'user-1',
      stationId: '2',
      startTime: DateTime.now().subtract(const Duration(days: 1)),
      endTime: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      kwhConsumed: 22.0,
      totalPrice: 396.0,
      status: 'completed',
    ),
    ChargingSession(
      id: '3',
      userId: 'user-1',
      stationId: '3',
      startTime: DateTime.now().subtract(const Duration(days: 3)),
      endTime: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
      kwhConsumed: 18.5,
      totalPrice: 407.0,
      status: 'completed',
    ),
  ];

  static List<Review> sampleReviews = [
    Review(
      id: '1',
      userId: 'user-2',
      stationId: '1',
      rating: 5.0,
      comment: 'Excellent service! Fast charging and friendly staff.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Review(
      id: '2',
      userId: 'user-3',
      stationId: '1',
      rating: 4.0,
      comment: 'Good charging speed but a bit crowded during peak hours.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Review(
      id: '3',
      userId: 'user-4',
      stationId: '3',
      rating: 5.0,
      comment: 'Best charging station in Kathmandu! Highly recommended.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static Map<String, dynamic> getUserData(String userId) {
    return {
      'id': userId,
      'full_name': 'Rajesh Kumar',
      'email': 'rajesh.kumar@example.com',
      'profile_image': null,
      'created_at': DateTime.now().subtract(const Duration(days: 90)),
    };
  }

  static Map<String, dynamic> getWalletData(String userId) {
    return {
      'user_id': userId,
      'balance': 5000.0,
      'last_updated': DateTime.now(),
    };
  }

  static List<String> getFAQs() {
    return [
      'How do I book a charging station?',
      'What payment methods are accepted?',
      'How can I track my charging session?',
      'What is the refund policy?',
      'How do I report an issue?',
      'Can I cancel a booking?',
      'Is there a loyalty program?',
      'How accurate is the availability data?',
    ];
  }

  static Map<String, String> getFAQAnswers() {
    return {
      'How do I book a charging station?':
          'Simply open the map, select a station, and tap "Start Charging". Your session will be recorded automatically.',
      'What payment methods are accepted?':
          'We accept eSewa, Khalti, and wallet balance. You can also prepay using any of these methods.',
      'How can I track my charging session?':
          'Go to the "Bookings" section to see all your current and past charging sessions with details.',
      'What is the refund policy?':
          'Refunds are processed within 3-5 business days if you cancel before 50% charging is completed.',
      'How do I report an issue?':
          'Use the Support section to create a ticket. Our team will respond within 24 hours.',
      'Can I cancel a booking?':
          'Yes, you can cancel up to 15 minutes after starting a session with a small cancellation fee.',
      'Is there a loyalty program?':
          'Yes! Each charge earns you points that can be redeemed for discounts.',
      'How accurate is the availability data?':
          'Our data updates in real-time. Availability is verified with each station every 30 seconds.',
    };
  }
}
