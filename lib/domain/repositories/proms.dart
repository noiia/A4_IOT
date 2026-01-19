import 'package:a4_iot/domain/entities/proms.dart';

abstract class PromsRepository {
  Future<List<Proms>> getProms();
  Future<Proms> getPromById(String id);

  Future<void> setProms(String name, String campusId);

  Future<void> updateProms(String id, String? name, String? campusId);

  Future<void> deleteProms(String id);
}
