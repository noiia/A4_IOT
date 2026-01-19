import 'package:a4_iot/domain/entities/proms.dart';
import 'package:a4_iot/domain/repositories/proms.dart';

class GetProms {
  final PromsRepository repository;

  GetProms(this.repository);

  Future<List<Proms>> call(String id) {
    return repository.getProms();
  }
}

class GetPromsById {
  final PromsRepository repository;

  GetPromsById(this.repository);

  Future<Proms> call(String id) {
    return repository.getPromById(id);
  }
}

class CreateProms {
  final PromsRepository repository;

  CreateProms(this.repository);

  Future<void> call({required String name, required String campusId}) {
    return repository.setProms(name, campusId);
  }
}

class UpdateProms {
  final PromsRepository repository;

  UpdateProms(this.repository);

  Future<void> call({
    required String id,
    required String name,
    required String campusId,
  }) {
    return repository.updateProms(id, name, campusId);
  }
}

class DeleteProms {
  final PromsRepository repository;

  DeleteProms(this.repository);

  Future<void> call(String id) {
    return repository.deleteProms(id);
  }
}
