import 'package:supabase_flutter/supabase_flutter.dart';

class RoomsRemoteDatasource {
  final SupabaseClient client;

  RoomsRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchRooms() async {
    return await client.from('rooms').select();
  }

  Future<Map<String, dynamic>> fetchRoomsById(String id) async {
    return await client.from('rooms').select().eq('id', id).single();
  }

  Future<void> createRoom(
    String promsId,
    String name,
    String campusId,
    int capacity,
  ) async {
    return await client.from('rooms').insert({
      'proms_id': promsId,
      'name': name,
      'capacity': capacity,
      'campus_id': campusId,
    });
  }

  Future<void> updateRoom(
    String id,
    String promsId,
    String? name,
    int? capacity,
    String? campusId,
  ) async {
    return await client
        .from('rooms')
        .update({
          'proms_id': promsId,
          'name': name,
          'capacity': capacity,
          'campus_id': campusId,
        })
        .eq('id', id);
  }

  Future<void> deleteRoom(String id) async {
    return await client.from('rooms').delete().eq('id', id);
  }
}
