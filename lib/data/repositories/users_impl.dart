import 'package:a4_iot/domain/entities/users.dart';
import 'package:a4_iot/domain/repositories/users.dart';
import 'package:a4_iot/data/datasources/local/users.dart';
import 'package:a4_iot/data/datasources/remote/users.dart';
import 'package:a4_iot/data/models/users.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDatasource remote;
  final UsersLocalDatasource local;

  UsersRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Users>> getUsers() async {
    try {
      final remoteData = await remote.fetchUsers();
      await local.cacheUsers(remoteData);

      return remoteData.map((e) => UsersModel.fromMap(e)).toList();
    } catch (_) {
      final localData = await local.getCachedUsers();
      return localData.map((e) => UsersModel.fromMap(e)).toList();
    }
  }

  @override
  Future<Users> getUsersByAuthUserId(String id) async {
    try {
      final remoteData = await remote
          .fetchUserByAuthUserId(id)
          .timeout(const Duration(seconds: 3));

      await local.cacheUser(remoteData);
      return UsersModel.fromMap(remoteData);
    } catch (_) {
      final localData = await local.getCachedUser();
      return localData != null
          ? UsersModel.fromMap(localData)
          : throw Exception('No cached user found');
    }
  }

  @override
  Future<Users> getUsersByBadgeId(String id) async {
    final remoteData = await remote.fetchUsersBadgeId(id);
    return UsersModel.fromMap(remoteData);
  }

  @override
  Future<void> setUsers(
    String firstName,
    String lastName,
    String password,
    String status,
    String badgeId,
    String promsId,
    String avatarUrl,
  ) async {
    await remote.createUser(
      firstName,
      lastName,
      password,
      status,
      badgeId,
      promsId,
      avatarUrl,
    );
  }

  @override
  Future<void> updateUsers(
    String id,
    String? firstName,
    String? lastName,
    String? password,
    String? status,
    String? badgeId,
    String? promsId,
    String? avatarUrl,
  ) async {
    {
      await remote.updateUser(
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

  @override
  Future<void> deleteUsers(String id) async {
    await remote.deleteUser(id);
  }
}
