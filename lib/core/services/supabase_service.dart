import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/constants.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  static SupabaseClient get client => Supabase.instance.client;
  static GoTrueClient get auth => client.auth;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SUPABASE_URL,
      anonKey: SUPABASE_ANON_KEY,
    );
  }

  // Auth Methods
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    final response = await auth.signUp(
      email: email,
      password: password,
      data: userData,
    );
    return response;
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static User? getCurrentUser() {
    return auth.currentUser;
  }

  static Stream<AuthState> authStateStream() {
    return auth.onAuthStateChange;
  }

  // Database Methods
  static Future<List<Map<String, dynamic>>> query(
    String table, {
    List<String>? select,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
  }) async {
    dynamic queryBuilder = client.from(table).select(select?.join(',') ?? '*');

    if (filters != null) {
      filters.forEach((key, value) {
        if (value is List) {
          queryBuilder = (queryBuilder as dynamic).in_(key, value);
        } else {
          queryBuilder = (queryBuilder as dynamic).eq(key, value);
        }
      });
    }

    if (orderBy != null) {
      queryBuilder = (queryBuilder as dynamic).order(orderBy, ascending: ascending);
    }

    final response = await queryBuilder;
    return List<Map<String, dynamic>>.from(response as List);
  }

  static Future<Map<String, dynamic>?> queryFirst(
    String table, {
    List<String>? select,
    Map<String, dynamic>? filters,
  }) async {
    var queryBuilder = client.from(table).select(select?.join(',') ?? '*');

    if (filters != null) {
      filters.forEach((key, value) {
        queryBuilder = queryBuilder.eq(key, value);
      });
    }

    final response = await queryBuilder.limit(1);
    final result = List<Map<String, dynamic>>.from(response as List);
    return result.isNotEmpty ? result.first : null;
  }

  static Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final response = await client.from(table).insert(data).select().single();
    return Map<String, dynamic>.from(response as Map);
  }

  static Future<Map<String, dynamic>> update(
    String table,
    Map<String, dynamic> data, {
    required String id,
  }) async {
    final response = await client
        .from(table)
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return Map<String, dynamic>.from(response as Map);
  }

  static Future<void> delete(String table, {required String id}) async {
    await client.from(table).delete().eq('id', id);
  }

  // Storage Methods
  static Future<String> uploadFile(
    String bucket,
    String path,
    dynamic file,
  ) async {
    await client.storage.from(bucket).upload(path, file);
    return getPublicUrl(bucket, path);
  }

  static String getPublicUrl(String bucket, String path) {
    return client.storage.from(bucket).getPublicUrl(path);
  }

  static Future<void> deleteFile(String bucket, String path) async {
    await client.storage.from(bucket).remove([path]);
  }

  // Realtime Subscription
  static RealtimeChannel subscribeToTable(String table) {
    return client.realtime.channel(table);
  }

  // Realtime Station Updates
  static RealtimeChannel subscribeToStations({
    required void Function(dynamic payload) onUpdate,
  }) {
    final channel = client.realtime.channel('public:stations');
    // Subscribe to changes in stations table
    // Note: Real-time subscriptions may require additional setup in Supabase dashboard
    channel.subscribe();
    return channel;
  }
}
