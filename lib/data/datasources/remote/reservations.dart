import 'package:supabase_flutter/supabase_flutter.dart';

class ReservationsRemoteDatasource {
  final SupabaseClient client;

  ReservationsRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchReservations() async {
    return await client.from('reservation').select();
  }

  Future<List<Map<String, dynamic>>> fetchReservationsById(String id) async {
    final test = await client.from('reservation').select().eq('id', id);
    print(test);
    return test;
  }

  Future<List<Map<String, dynamic>>> fetchReservationsByIds(
    List<String> ids,
  ) async {
    return await client.from('reservation').select().eq('id', ids);
  }

  Future<List<Map<String, dynamic>>> fetchReservationsFromUsersReservesByUserId(
    String id,
  ) async {
    return await Supabase.instance.client
        .from('reservation')
        .select('*, users_reserves!inner(user_id)')
        .eq('users_reserves.user_id', id);
  }

  Future<void> createReservation(
    String usersReserves,
    DateTime start,
    DateTime ends,
  ) async {
    return await client.from('reservation').insert({
      'users_reserves': usersReserves,
      'start': start,
      'ends': ends,
    });
  }

  Future<void> updateReservation(
    String id,
    String? usersReserves,
    DateTime? start,
    DateTime? ends,
  ) async {
    return await client
        .from('reservation')
        .update({'users_reserves': usersReserves, 'start': start, 'ends': ends})
        .eq('id', id);
  }

  Future<void> deleteReservation(String id) async {
    return await client.from('reservation').delete().eq('id', id);
  }
}
