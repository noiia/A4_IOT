import 'package:a4_iot/domain/entities/users_reserves.dart';
import 'package:a4_iot/domain/repositories/users_reserves.dart';

class GetUsersReserves {
  final UsersReservesRepository repository;

  GetUsersReserves(this.repository);

  Future<List<UsersReserves>> call(String id) {
    return repository.getUsersReserves();
  }
}

class GetUsersReservesById {
  final UsersReservesRepository repository;

  GetUsersReservesById(this.repository);

  Future<List<UsersReserves>> call(String id) {
    return repository.getUsersReservesById(id);
  }
}

class GetUsersReservesByUsersId {
  final UsersReservesRepository repository;

  GetUsersReservesByUsersId(this.repository);

  Future<List<UsersReserves>> call(String id) {
    return repository.getUsersReservesById(id);
  }
}

class GetUsersReservesByReservationsId {
  final UsersReservesRepository repository;

  GetUsersReservesByReservationsId(this.repository);

  Future<List<UsersReserves>> call(String id) {
    return repository.getUsersReservesById(id);
  }
}

class CreateUsersReserves {
  final UsersReservesRepository repository;

  CreateUsersReserves(this.repository);

  Future<void> call({required String name, required String campusId}) {
    return repository.setUsersReserves(name, campusId);
  }
}

class UpdateUsersReserves {
  final UsersReservesRepository repository;

  UpdateUsersReserves(this.repository);

  Future<void> call({
    required String id,
    required String name,
    required String campusId,
  }) {
    return repository.updateUsersReserves(id, name, campusId);
  }
}

class DeleteUsersReserves {
  final UsersReservesRepository repository;

  DeleteUsersReserves(this.repository);

  Future<void> call(String id) {
    return repository.deleteUsersReserves(id);
  }
}
