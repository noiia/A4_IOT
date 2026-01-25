import 'package:supabase_flutter/supabase_flutter.dart';

class UsersRemoteDatasource {
  final SupabaseClient client;

  UsersRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    return await client.from('users').select();
  }

  Future<Map<String, dynamic>> fetchUserByAuthUserId(String id) async {
    return await client.from('users').select().eq('auth_user_id', id).single();
  }

  Future<Map<String, dynamic>> fetchUsersBadgeId(String id) async {
    return await client.from('users').select().eq('badge_id', id).single();
  }

  Future<Map<String, dynamic>?> fetchHomeUsersByAuthUserId(String id) async {
    final res = await client
        .rpc('get_home_user', params: {'uid': id})
        .maybeSingle();

    return res;
  }

  Future<void> createUser(
    String firstName,
    String lastName,
    String password,
    String status,
    String badgeId,
    String promsId,
    String avatarUrl,
  ) async {
    return await client.from('users').insert({
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'status': status,
      'badge_id': badgeId,
      'proms_id': promsId,
      'avatar_url': avatarUrl,
    });
  }

  Future<void> updateUser(
    String id,
    String? firstName,
    String? lastName,
    String? password,
    String? status,
    String? badgeId,
    String? promsId,
    String? avatarUrl,
  ) async {
    return await client
        .from('users')
        .update({
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
          'status': status,
          'badge_id': badgeId,
          'proms_id': promsId,
          'avatar_url': avatarUrl,
        })
        .eq('id', id);
  }

  Future<void> deleteUser(String id) async {
    return await client.from('users').delete().eq('id', id);
  }
}
