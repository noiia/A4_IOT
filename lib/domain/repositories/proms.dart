import 'package:a4_iot/domain/entities/proms.dart';

abstract class PromsRepository {
  Future<List<Proms>> getProms();
  Future<Proms> getPromById(String id);

  Future<void> setProms(String name, String city);

  Future<void> updateProms(String id, String? name, String? city);

  Future<void> deleteProms(String id);
}
