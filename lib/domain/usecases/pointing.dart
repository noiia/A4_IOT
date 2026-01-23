import 'package:a4_iot/domain/entities/pointing.dart';
import 'package:a4_iot/domain/repositories/pointing.dart';

class GetPointing {
  final PointingRepository repository;

  GetPointing(this.repository);

  Future<List<Pointing>> call() {
    return repository.getPointings();
  }
}

class GetPointingById {
  final PointingRepository repository;

  GetPointingById(this.repository);

  Future<Pointing> call(String id) {
    return repository.getPointingById(id);
  }
}

class GetLastPointingByUserBadgeId {
  final PointingRepository repository;

  GetLastPointingByUserBadgeId(this.repository);

  Future<Pointing> call(String userBadgeId) {
    return repository.getLastPointingByUserBadgeId(userBadgeId);
  }
}

class GetPointingsByUserBadgeId {
  final PointingRepository repository;

  GetPointingsByUserBadgeId(this.repository);

  Future<List<Pointing>> call(String userBadgeId) {
    return repository.getPointingsByUserBadgeId(userBadgeId);
  }
}

class CreatePointing {
  final PointingRepository repository;

  CreatePointing(this.repository);

  Future<void> call({required String userBadgeId}) {
    return repository.setPointing(userBadgeId);
  }
}
