import 'package:supabase_flutter/supabase_flutter.dart';

class CampusRemoteDatasource {
  final SupabaseClient client;

  CampusRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchCampus() async {
    return await client.from('campus').select();
  }

  Future<Map<String, dynamic>> fetchCampusById(String id) async {
    return await client.from('campus').select().eq('id', id).single();
  }

  Future<void> createCampus(
    String name,
    String city,
    String? address,
    String? zipCode,
  ) async {
    return await client.from('campus').insert({
      'name': name,
      'city': city,
      'address': address,
      'zip_code': zipCode,
    });
  }

  Future<void> updateCampus(
    String id,
    String? name,
    String? city,
    String? address,
    String? zipCode,
  ) async {
    return await client
        .from('campus')
        .update({
          'name': name,
          'city': city,
          'address': address,
          'zip_code': zipCode,
        })
        .eq('id', id);
  }

  Future<void> deleteCampus(String id) async {
    return await client.from('campus').delete().eq('id', id);
  }
}
