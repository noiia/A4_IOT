import 'package:a4_iot/domain/entities/users.dart';
import 'package:a4_iot/domain/repositories/users.dart';

class GetUsers {
  final UsersRepository repository;

  GetUsers(this.repository);

  Future<List<Users>> call(String id) {
    return repository.getUsers();
  }
}

class GetUsersByAuthUserId {
  final UsersRepository repository;

  GetUsersByAuthUserId(this.repository);

  Future<Users> call(String id) {
    return repository.getUsersByAuthUserId(id);
  }
}

class GetUsersByBadgeId {
  final UsersRepository repository;

  GetUsersByBadgeId(this.repository);

  Future<Users> call(String id) {
    return repository.getUsersByBadgeId(id);
  }
}

class CreateUsers {
  final UsersRepository repository;

  CreateUsers(this.repository);

  Future<void> call({
    required String firstName,
    required String lastName,
    required String password,
    required String status,
    required String badgeId,
    required String promsId,
    required String avatarUrl,
  }) {
    return repository.setUsers(
      firstName,
      lastName,
      password,
      status,
      badgeId,
      promsId,
      avatarUrl,
    );
  }
}

class UpdateUsers {
  final UsersRepository repository;

  UpdateUsers(this.repository);

  Future<void> call({
    required String id,
    String? firstName,
    String? lastName,
    String? password,
    String? status,
    String? badgeId,
    String? promsId,
    String? avatarUrl,
  }) {
    return repository.updateUsers(
      id,
      firstName,
      lastName,
      password,
      status,
      badgeId,
      promsId,
      avatarUrl,
    );
  }
}

class DeleteUsers {
  final UsersRepository repository;

  DeleteUsers(this.repository);

  Future<void> call(String id) {
    return repository.deleteUsers(id);
  }
}
