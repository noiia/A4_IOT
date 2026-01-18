import 'package:supabase_flutter/supabase_flutter.dart';

class PromsRemoteDatasource {
  final SupabaseClient client;

  PromsRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchProms() async {
    return await client.from('proms').select();
  }

  Future<Map<String, dynamic>> fetchPromById(String id) async {
    return await client.from('proms').select().eq('id', id).single();
  }

  Future<void> createProm(String name, String city) async {
    return await client.from('proms').insert({'name': name, 'city': city});
  }

  Future<void> updateProm(String id, String? name, String? city) async {
    return await client
        .from('proms')
        .update({'name': name, 'city': city})
        .eq('id', id);
  }

  Future<void> deleteProm(String id) async {
    return await client.from('proms').delete().eq('id', id);
  }
}
