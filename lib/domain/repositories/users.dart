import 'package:a4_iot/domain/entities/users.dart';

abstract class UsersRepository {
  Future<List<Users>> getUsers();
  Future<Users> getUsersByAuthUserId(String id);
  Future<Users> getUsersByBadgeId(String id);

  Future<void> setUsers(
    String firstName,
    String lastName,
    String password,
    String status,
    String badgeId,
    String promsId,
    String avatarUrl,
  );

  Future<void> updateUsers(
    String id,
    String? firstName,
    String? lastName,
    String? password,
    String? status,
    String? badgeId,
    String? promsId,
    String? avatarUrl,
  );

  Future<void> deleteUsers(String id);
}
