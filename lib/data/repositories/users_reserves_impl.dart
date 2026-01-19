import 'package:a4_iot/domain/entities/users_reserves.dart';
import 'package:a4_iot/domain/repositories/users_reserves.dart';
import 'package:a4_iot/data/datasources/local/users_reserves.dart';
import 'package:a4_iot/data/datasources/remote/users_reserves.dart';
import 'package:a4_iot/data/models/users_reserves.dart';

class UsersReservesRepositoryImpl implements UsersReservesRepository {
  final UsersReservesRemoteDatasource remote;
  final UsersReservesLocalDatasource local;

  UsersReservesRepositoryImpl(this.remote, this.local);

  @override
  Future<List<UsersReserves>> getUsersReserves() async {
    try {
      final remoteData = await remote.fetchUsersReserves();
      await local.cacheUsersReserves(remoteData);

      return remoteData.map((e) => UsersReservesModel.fromMap(e)).toList();
    } catch (_) {
      final localData = await local.getCachedUsersReserves();
      return localData.map((e) => UsersReservesModel.fromMap(e)).toList();
    }
  }

  @override
  Future<List<UsersReserves>> getUsersReservesById(String id) async {
    final remoteData = await remote.fetchUsersReservesById(id);
    return remoteData.map((e) => UsersReservesModel.fromMap(e)).toList();
  }

  @override
  Future<List<UsersReserves>> getUsersReservesByUserId(String id) async {
    final remoteData = await remote.fetchUsersReservesByUserId(id);
    return remoteData.map((e) => UsersReservesModel.fromMap(e)).toList();
  }

  @override
  Future<List<UsersReserves>> getUsersReservesByReservationId(String id) async {
    final remoteData = await remote.fetchUsersReservesByReservationId(id);
    return remoteData.map((e) => UsersReservesModel.fromMap(e)).toList();
  }

  @override
  Future<void> setUsersReserves(String userId, String reservationId) async {
    await remote.createUsersReserves(userId, reservationId);
  }

  @override
  Future<void> updateUsersReserves(
    String id,
    String? userId,
    String? reservationId,
  ) async {
    {
      await remote.updateUsersReserves(id, userId, reservationId);
    }
  }

  @override
  Future<void> deleteUsersReserves(String id) async {
    await remote.deleteUsersReserves(id);
  }
}
