import 'package:a4_iot/domain/entities/campus.dart';
import 'package:a4_iot/domain/repositories/campus.dart';

class GetCampus {
  final CampusRepository repository;

  GetCampus(this.repository);

  Future<List<Campus>> call(String id) {
    return repository.getCampus();
  }
}

class GetCampusById {
  final CampusRepository repository;

  GetCampusById(this.repository);

  Future<Campus> call(String id) {
    return repository.getCampusById(id);
  }
}

class CreateCampus {
  final CampusRepository repository;

  CreateCampus(this.repository);

  Future<void> call({
    required String name,
    required String city,
    required String address,
    required String zipCode,
  }) {
    return repository.setCampus(name, city, address, zipCode);
  }
}

class UpdateCampus {
  final CampusRepository repository;

  UpdateCampus(this.repository);

  Future<void> call({
    required String id,
    required String name,
    required String city,
    required String address,
    required String zipCode,
  }) {
    return repository.updateCampus(id, name, city, address, zipCode);
  }
}

class DeleteCampus {
  final CampusRepository repository;

  DeleteCampus(this.repository);

  Future<void> call(String id) {
    return repository.deleteCampus(id);
  }
}
