class User {
  final String id;
  final String fullName;
  final String email;
  final String? profileImage;
  final DateTime createdAt;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.profileImage,
    required this.createdAt,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? profileImage,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'profile_image': profileImage,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      fullName: map['full_name'] as String? ?? '',
      email: map['email'] as String,
      profileImage: map['profile_image'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
    );
  }
}

class ChargingStation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final int availableSlots;
  final int totalSlots;
  final List<String> chargerTypes; // e.g., ['Fast', 'Slow', 'AC']
  final double pricePerKwh;
  final List<String> images;
  final DateTime createdAt;
  final double? rating;

  ChargingStation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.availableSlots,
    required this.totalSlots,
    required this.chargerTypes,
    required this.pricePerKwh,
    required this.images,
    required this.createdAt,
    this.rating,
  });

  bool get isAvailable => availableSlots > 0;

  ChargingStation copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    int? availableSlots,
    int? totalSlots,
    List<String>? chargerTypes,
    double? pricePerKwh,
    List<String>? images,
    DateTime? createdAt,
    double? rating,
  }) {
    return ChargingStation(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      availableSlots: availableSlots ?? this.availableSlots,
      totalSlots: totalSlots ?? this.totalSlots,
      chargerTypes: chargerTypes ?? this.chargerTypes,
      pricePerKwh: pricePerKwh ?? this.pricePerKwh,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'available_slots': availableSlots,
      'total_slots': totalSlots,
      'charger_types': chargerTypes,
      'price_per_kwh': pricePerKwh,
      'images': images,
      'created_at': createdAt.toIso8601String(),
      'rating': rating,
    };
  }

  factory ChargingStation.fromMap(Map<String, dynamic> map) {
    return ChargingStation(
      id: map['id'] as String,
      name: map['name'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      address: map['address'] as String,
      availableSlots: map['available_slots'] as int? ?? 0,
      totalSlots: map['total_slots'] as int? ?? 0,
      chargerTypes: List<String>.from(map['charger_types'] as List? ?? []),
      pricePerKwh: (map['price_per_kwh'] as num).toDouble(),
      images: List<String>.from(map['images'] as List? ?? []),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      rating: (map['rating'] as num?)?.toDouble(),
    );
  }
}

class ChargingSession {
  final String id;
  final String userId;
  final String stationId;
  final DateTime startTime;
  final DateTime? endTime;
  final double? kwhConsumed;
  final double? totalPrice;
  final String status; // 'ongoing', 'completed', 'cancelled'

  ChargingSession({
    required this.id,
    required this.userId,
    required this.stationId,
    required this.startTime,
    this.endTime,
    this.kwhConsumed,
    this.totalPrice,
    this.status = 'ongoing',
  });

  bool get isOngoing => status == 'ongoing';

  ChargingSession copyWith({
    String? id,
    String? userId,
    String? stationId,
    DateTime? startTime,
    DateTime? endTime,
    double? kwhConsumed,
    double? totalPrice,
    String? status,
  }) {
    return ChargingSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      stationId: stationId ?? this.stationId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      kwhConsumed: kwhConsumed ?? this.kwhConsumed,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'station_id': stationId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'kwh_consumed': kwhConsumed,
      'total_price': totalPrice,
      'status': status,
    };
  }

  factory ChargingSession.fromMap(Map<String, dynamic> map) {
    return ChargingSession(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      stationId: map['station_id'] as String,
      startTime: DateTime.parse(map['start_time'] as String),
      endTime: map['end_time'] != null
          ? DateTime.parse(map['end_time'] as String)
          : null,
      kwhConsumed: (map['kwh_consumed'] as num?)?.toDouble(),
      totalPrice: (map['total_price'] as num?)?.toDouble(),
      status: map['status'] as String? ?? 'ongoing',
    );
  }
}

class Favorite {
  final String id;
  final String userId;
  final String stationId;
  final DateTime createdAt;

  Favorite({
    required this.id,
    required this.userId,
    required this.stationId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'station_id': stationId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      stationId: map['station_id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}

class SupportTicket {
  final String id;
  final String userId;
  final String subject;
  final String message;
  final String status;
  final DateTime createdAt;

  SupportTicket({
    required this.id,
    required this.userId,
    required this.subject,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'subject': subject,
      'message': message,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory SupportTicket.fromMap(Map<String, dynamic> map) {
    return SupportTicket(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      subject: map['subject'] as String,
      message: map['message'] as String,
      status: map['status'] as String? ?? 'open',
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}

class Review {
  final String id;
  final String userId;
  final String stationId;
  final double rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.stationId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'station_id': stationId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      stationId: map['station_id'] as String,
      rating: (map['rating'] as num).toDouble(),
      comment: map['comment'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}

class Wallet {
  final String userId;
  final double balance;
  final DateTime lastUpdated;

  Wallet({
    required this.userId,
    required this.balance,
    required this.lastUpdated,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'balance': balance,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      userId: map['user_id'] as String,
      balance: (map['balance'] as num).toDouble(),
      lastUpdated: DateTime.parse(map['last_updated'] as String),
    );
  }
}

class Transaction {
  final String id;
  final String userId;
  final double amount;
  final String paymentMethod; // 'esewa', 'khalti', 'wallet'
  final String status; // 'pending', 'completed', 'failed'
  final String? sessionId;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    this.sessionId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'payment_method': paymentMethod,
      'status': status,
      'session_id': sessionId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      amount: (map['amount'] as num).toDouble(),
      paymentMethod: map['payment_method'] as String,
      status: map['status'] as String,
      sessionId: map['session_id'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
