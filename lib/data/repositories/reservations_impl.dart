import 'package:a4_iot/domain/entities/reservations.dart';
import 'package:a4_iot/domain/repositories/reservations.dart';
import 'package:a4_iot/data/datasources/local/reservations.dart';
import 'package:a4_iot/data/datasources/remote/reservations.dart';
import 'package:a4_iot/data/models/reservations.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  final ReservationsRemoteDatasource remote;
  final ReservationsLocalDatasource local;

  ReservationsRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Reservations>> getReservations() async {
    try {
      final remoteData = await remote.fetchReservations();
      await local.cacheReservations(remoteData);

      return remoteData.map((e) => ReservationsModel.fromMap(e)).toList();
    } catch (_) {
      final localData = await local.getCachedReservations();
      return localData.map((e) => ReservationsModel.fromMap(e)).toList();
    }
  }

  @override
  Future<List<Reservations>> getReservationsById(String id) async {
    final remoteData = await remote.fetchReservationsById(id);
    return remoteData.map((e) => ReservationsModel.fromMap(e)).toList();
  }

  @override
  Future<List<Reservations>> getReservationsByIds(List<String> ids) async {
    final remoteData = await remote.fetchReservationsByIds(ids);
    return remoteData.map((e) => ReservationsModel.fromMap(e)).toList();
  }

  @override
  Future<List<Reservations>> getReservationsFromUsersReservesByUserId(
    String id,
  ) async {
    final remoteData = await remote.fetchReservationsFromUsersReservesByUserId(
      id,
    );
    return remoteData
        .map((e) => ReservationsModel.fromMap(e['reservation']))
        .toList();
  }

  @override
  Future<void> setReservations(
    String usersReserves,
    DateTime start,
    DateTime ends,
  ) async {
    await remote.createReservation(usersReserves, start, ends);
  }

  @override
  Future<void> updateReservations(
    String id,
    String? usersReserves,
    DateTime? start,
    DateTime? ends,
  ) async {
    {
      await remote.updateReservation(id, usersReserves, start, ends);
    }
  }

  @override
  Future<void> deleteReservations(String id) async {
    await remote.deleteReservation(id);
  }
}
