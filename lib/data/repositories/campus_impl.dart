import 'package:a4_iot/domain/entities/campus.dart';
import 'package:a4_iot/domain/repositories/campus.dart';
import 'package:a4_iot/data/datasources/local/campus.dart';
import 'package:a4_iot/data/datasources/remote/campus.dart';
import 'package:a4_iot/data/models/campus.dart';

class CampusRepositoryImpl implements CampusRepository {
  final CampusRemoteDatasource remote;
  final CampusLocalDatasource local;

  CampusRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Campus>> getCampus() async {
    try {
      final remoteData = await remote.fetchCampus();
      await local.cacheCampus(remoteData);

      return remoteData.map((e) => CampusModel.fromMap(e)).toList();
    } catch (_) {
      final localData = await local.getCachedCampus();
      return localData.map((e) => CampusModel.fromMap(e)).toList();
    }
  }

  @override
  Future<Campus> getCampusById(String id) async {
    try {
      final remoteData = await remote
          .fetchCampusById(id)
          .timeout(const Duration(seconds: 3));
      await local.cacheUserCampus(remoteData);

      return CampusModel.fromMap(remoteData);
    } catch (_) {
      final localData = await local.getCachedUserCampus();
      return localData != null
          ? CampusModel.fromMap(localData)
          : throw Exception('No cached campus found');
    }
  }

  @override
  Future<void> setCampus(
    String name,
    String city,
    String address,
    String zipCode,
  ) async {
    await remote.createCampus(name, city, address, zipCode);
  }

  @override
  Future<void> updateCampus(
    String id,
    String? name,
    String? city,
    String? address,
    String? zipCode,
  ) async {
    {
      await remote.updateCampus(id, name, city, address, zipCode);
    }
  }

  @override
  Future<void> deleteCampus(String id) async {
    await remote.deleteCampus(id);
  }
}
