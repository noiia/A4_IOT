import 'package:a4_iot/domain/entities/pointing.dart';
import 'package:a4_iot/domain/repositories/pointing.dart';
import 'package:a4_iot/data/datasources/local/pointing.dart';
import 'package:a4_iot/data/datasources/remote/pointing.dart';
import 'package:a4_iot/data/models/pointing.dart';

class PointingRepositoryImpl implements PointingRepository {
  final PointingRemoteDatasource remote;
  final PointingLocalDatasource local;

  PointingRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Pointing>> getPointings() async {
    try {
      final remoteData = await remote.fetchPointings();
      await local.cachePointings(remoteData);

      return remoteData.map((e) => PointingModel.fromMap(e)).toList();
    } catch (_) {
      final localData = await local.getCachedPointings();
      return localData.map((e) => PointingModel.fromMap(e)).toList();
    }
  }

  @override
  Future<Pointing> getPointingById(String id) async {
    final remoteData = await remote
        .fetchPointingById(id)
        .timeout(const Duration(seconds: 3));

    return PointingModel.fromMap(remoteData);
  }

  @override
  Future<Pointing> getLastPointingByUserBadgeId(String userBadgeId) async {
    final remoteData = await remote
        .fetchLastPointingByUserBadgeId(userBadgeId)
        .timeout(const Duration(seconds: 3));

    return PointingModel.fromMap(remoteData);
  }

  @override
  Future<List<Pointing>> getPointingsByUserBadgeId(String userBadgeId) async {
    try {
      final remoteData = await remote
          .fetchPointingsByUserBadgeId(userBadgeId)
          .timeout(const Duration(seconds: 3));
      await local.cacheUserPointings(remoteData);

      return remoteData.map((e) => PointingModel.fromMap(e)).toList();
    } catch (_) {
      final localData = await local.getCachedUserPointings();
      return localData != null
          ? localData.map((e) => PointingModel.fromMap(e)).toList()
          : throw Exception('No cached pointing found');
    }
  }

  @override
  Future<void> setPointing(String userBadgeId, DateTime dateTime) async {
    //Datetime without seconds
    final date = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );
    await remote.createPointing(userBadgeId, date);
  }
}
