import 'package:supabase_flutter/supabase_flutter.dart';

class ReservationsRemoteDatasource {
  final SupabaseClient client;

  ReservationsRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchReservations() async {
    return await client.from('reservations').select();
  }

  Future<Map<String, dynamic>> fetchReservationsById(String id) async {
    return await client.from('reservations').select().eq('id', id).single();
  }

  Future<void> createReservation(
    String usersReserves,
    DateTime start,
    DateTime ends,
  ) async {
    return await client.from('reservations').insert({
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
        .from('reservations')
        .update({'users_reserves': usersReserves, 'start': start, 'ends': ends})
        .eq('id', id);
  }

  Future<void> deleteReservation(String id) async {
    return await client.from('reservations').delete().eq('id', id);
  }
}
