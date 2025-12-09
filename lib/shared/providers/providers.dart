import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/models/models.dart';
import '../../core/services/supabase_service.dart';
import 'package:uuid/uuid.dart';

// Auth State Notifier
class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null) {
    _initializeAuth();
  }

  void _initializeAuth() {
    final user = SupabaseService.getCurrentUser();
    if (user != null) {
      // Load user data from database
      _loadUserData(user.id);
    }
  }

  Future<void> _loadUserData(String userId) async {
    try {
      final userData =
          await SupabaseService.queryFirst('users', filters: {'id': userId});
      if (userData != null) {
        state = User.fromMap(userData);
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await SupabaseService.signUp(
        email: email,
        password: password,
        userData: {'full_name': fullName},
      );

      if (response.user != null) {
        // Create user record in database
        await SupabaseService.insert('users', {
          'id': response.user!.id,
          'full_name': fullName,
          'email': email,
          'created_at': DateTime.now().toIso8601String(),
        });

        state = User(
          id: response.user!.id,
          fullName: fullName,
          email: email,
          createdAt: DateTime.now(),
        );
      }
    } catch (e) {
      print('Signup error: $e');
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await SupabaseService.signIn(
        email: email,
        password: password,
      );

      if (response.user != null) {
        await _loadUserData(response.user!.id);
      }
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await SupabaseService.signOut();
      state = null;
    } catch (e) {
      print('Logout error: $e');
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String fullName,
    String? profileImage,
  }) async {
    if (state == null) return;

    try {
      final updatedUser = await SupabaseService.update(
        'users',
        {
          'full_name': fullName,
          if (profileImage != null) 'profile_image': profileImage,
        },
        id: state!.id,
      );

      state = User.fromMap(updatedUser);
    } catch (e) {
      print('Update profile error: $e');
      rethrow;
    }
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});

// Charging Stations Provider
class StationsNotifier extends StateNotifier<AsyncValue<List<ChargingStation>>> {
  StationsNotifier() : super(const AsyncValue.loading()) {
    _loadStations();
  }

  Future<void> _loadStations() async {
    try {
      final stations = await SupabaseService.query(
        'stations',
        orderBy: 'created_at',
        ascending: false,
      );
      state = AsyncValue.data(
        stations.map((s) => ChargingStation.fromMap(s)).toList(),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addStation(ChargingStation station) async {
    try {
      await SupabaseService.insert('stations', station.toMap());
      await _loadStations();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateStation(ChargingStation station) async {
    try {
      await SupabaseService.update('stations', station.toMap(), id: station.id);
      await _loadStations();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteStation(String stationId) async {
    try {
      await SupabaseService.delete('stations', id: stationId);
      await _loadStations();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void refresh() => _loadStations();
}

final stationsProvider = StateNotifierProvider<StationsNotifier,
    AsyncValue<List<ChargingStation>>>((ref) {
  return StationsNotifier();
});

// Sessions Provider
class SessionsNotifier extends StateNotifier<AsyncValue<List<ChargingSession>>> {
  SessionsNotifier(this.userId) : super(const AsyncValue.loading()) {
    _loadSessions();
  }

  final String userId;

  Future<void> _loadSessions() async {
    try {
      final sessions = await SupabaseService.query(
        'sessions',
        filters: {'user_id': userId},
        orderBy: 'start_time',
        ascending: false,
      );
      state = AsyncValue.data(
        sessions.map((s) => ChargingSession.fromMap(s)).toList(),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<ChargingSession> startSession(String stationId) async {
    try {
      final sessionId = const Uuid().v4();
      final session = ChargingSession(
        id: sessionId,
        userId: userId,
        stationId: stationId,
        startTime: DateTime.now(),
        status: 'ongoing',
      );

      await SupabaseService.insert('sessions', session.toMap());
      await _loadSessions();
      return session;
    } catch (e) {
      rethrow;
    }
  }

  Future<ChargingSession> endSession({
    required String sessionId,
    required double kwhConsumed,
    required double totalPrice,
  }) async {
    try {
      final updatedSession = await SupabaseService.update(
        'sessions',
        {
          'end_time': DateTime.now().toIso8601String(),
          'kwh_consumed': kwhConsumed,
          'total_price': totalPrice,
          'status': 'completed',
        },
        id: sessionId,
      );
      await _loadSessions();
      return ChargingSession.fromMap(updatedSession);
    } catch (e) {
      rethrow;
    }
  }

  void refresh() => _loadSessions();
}

final sessionsProvider =
    StateNotifierProvider.family<SessionsNotifier, AsyncValue<List<ChargingSession>>,
        String>((ref, userId) {
  return SessionsNotifier(userId);
});

// Favorites Provider
class FavoritesNotifier extends StateNotifier<AsyncValue<List<String>>> {
  FavoritesNotifier(this.userId) : super(const AsyncValue.loading()) {
    _loadFavorites();
  }

  final String userId;

  Future<void> _loadFavorites() async {
    try {
      final favorites = await SupabaseService.query(
        'favorites',
        filters: {'user_id': userId},
      );
      state = AsyncValue.data(
        favorites.map((f) => f['station_id'] as String).toList(),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addFavorite(String stationId) async {
    try {
      await SupabaseService.insert('favorites', {
        'id': const Uuid().v4(),
        'user_id': userId,
        'station_id': stationId,
        'created_at': DateTime.now().toIso8601String(),
      });
      await _loadFavorites();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> removeFavorite(String stationId) async {
    try {
      final favorite = await SupabaseService.queryFirst(
        'favorites',
        filters: {'user_id': userId, 'station_id': stationId},
      );

      if (favorite != null) {
        await SupabaseService.delete('favorites', id: favorite['id']);
        await _loadFavorites();
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void refresh() => _loadFavorites();
}

final favoritesProvider = StateNotifierProvider.family<
    FavoritesNotifier, AsyncValue<List<String>>, String>((ref, userId) {
  return FavoritesNotifier(userId);
});

// Current Charging Session Provider
final currentSessionProvider = StateProvider<ChargingSession?>((ref) => null);

// Wallet Balance Provider
final walletProvider = StateProvider<double>((ref) => 0.0);
