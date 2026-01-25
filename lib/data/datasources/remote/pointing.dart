import 'package:supabase_flutter/supabase_flutter.dart';

class PointingRemoteDatasource {
  final SupabaseClient client;

  PointingRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchPointings() async {
    return await client.from('pointing').select();
  }

  Future<Map<String, dynamic>> fetchPointingById(String id) async {
    return await client.from('pointing').select().eq('id', id).single();
  }

  Future<Map<String, dynamic>> fetchLastPointingByUserBadgeId(
    String userBadgeId,
  ) async {
    return await client
        .from('pointing')
        .select()
        .eq('user_badge_id', userBadgeId)
        .order('created_at', ascending: false)
        .limit(1)
        .single();
  }

  Future<List<Map<String, dynamic>>> fetchPointingsByUserBadgeId(
    String userBadgeId,
  ) async {
    return await client
        .from('pointing')
        .select()
        .eq('user_badge_id', userBadgeId);
  }

  Future<void> createPointing(String userBadgeId) async {
    return await client.from('pointing').insert({'user_badge_id': userBadgeId});
  }
}
