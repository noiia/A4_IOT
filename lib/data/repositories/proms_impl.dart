import 'package:a4_iot/domain/entities/proms.dart';
import 'package:a4_iot/domain/repositories/proms.dart';
import 'package:a4_iot/data/datasources/local/proms.dart';
import 'package:a4_iot/data/datasources/remote/proms.dart';
import 'package:a4_iot/data/models/proms.dart';

class PromsRepositoryImpl implements PromsRepository {
  final PromsRemoteDatasource remote;
  final PromsLocalDatasource local;

  PromsRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Proms>> getProms() async {
    try {
      final remoteData = await remote.fetchProms();
      await local.cacheProms(remoteData);

      return remoteData.map((e) => PromsModel.fromMap(e)).toList();
    } catch (_) {
      final localData = await local.getCachedProms();
      return localData.map((e) => PromsModel.fromMap(e)).toList();
    }
  }

  @override
  Future<Proms> getPromById(String id) async {
    try {
      final remoteData = await remote
          .fetchPromById(id)
          .timeout(const Duration(seconds: 3));
      await local.cacheUserProms(remoteData);

      return PromsModel.fromMap(remoteData);
    } catch (_) {
      final localData = await local.getCachedUserProm();
      return localData != null
          ? PromsModel.fromMap(localData)
          : throw Exception('No cached proms found');
    }
  }

  @override
  Future<void> setProms(String name, String campusId) async {
    await remote.createProm(name, campusId);
  }

  @override
  Future<void> updateProms(String id, String? name, String? campusId) async {
    {
      await remote.updateProm(id, name, campusId);
    }
  }

  @override
  Future<void> deleteProms(String id) async {
    await remote.deleteProm(id);
  }
}
