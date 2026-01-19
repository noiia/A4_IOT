import 'package:a4_iot/domain/entities/campus.dart';

abstract class CampusRepository {
  Future<List<Campus>> getCampus();
  Future<Campus> getCampusById(String id);

  Future<void> setCampus(
    String name,
    String city,
    String address,
    String zipCode,
  );

  Future<void> updateCampus(
    String id,
    String? name,
    String? city,
    String? address,
    String? zipCode,
  );

  Future<void> deleteCampus(String id);
}
