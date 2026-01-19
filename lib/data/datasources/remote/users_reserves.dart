import 'package:supabase_flutter/supabase_flutter.dart';

class UsersReservesRemoteDatasource {
  final SupabaseClient client;

  UsersReservesRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchUsersReserves() async {
    return await client.from('users_reserves').select();
  }

  Future<List<Map<String, dynamic>>> fetchUsersReservesById(String id) async {
    return await client.from('users_reserves').select().eq('id', id);
  }

  Future<List<Map<String, dynamic>>> fetchUsersReservesByUserId(
    String id,
  ) async {
    return await client.from('users_reserves').select().eq('user_id', id);
  }

  Future<List<Map<String, dynamic>>> fetchUsersReservesByReservationId(
    String id,
  ) async {
    return await client
        .from('users_reserves')
        .select()
        .eq('reservation_id', id);
  }

  Future<void> createUsersReserves(String userId, String reservationId) async {
    return await client.from('users_reserves').insert({
      'user_id': userId,
      'reservation_id': reservationId,
    });
  }

  Future<void> updateUsersReserves(
    String id,
    String? userId,
    String? reservationId,
  ) async {
    return await client
        .from('users_reserves')
        .update({'user_id': userId, 'reservation_id': reservationId})
        .eq('id', id);
  }

  Future<void> deleteUsersReserves(String id) async {
    return await client.from('users_reserves').delete().eq('id', id);
  }
}
