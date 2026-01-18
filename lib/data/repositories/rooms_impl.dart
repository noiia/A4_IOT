import 'package:a4_iot/domain/entities/rooms.dart';
import 'package:a4_iot/domain/repositories/rooms.dart';
import 'package:a4_iot/data/datasources/local/rooms.dart';
import 'package:a4_iot/data/datasources/remote/rooms.dart';
import 'package:a4_iot/data/models/rooms.dart';

class RoomsRepositoryImpl implements RoomsRepository {
  final RoomsRemoteDatasource remote;
  final RoomsLocalDatasource local;

  RoomsRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Rooms>> getRooms() async {
    try {
      final remoteData = await remote.fetchRooms();
      await local.cacheRooms(remoteData);

      return remoteData.map((e) => RoomsModel.fromMap(e)).toList();
    } catch (_) {
      final localData = await local.getCachedRooms();
      return localData.map((e) => RoomsModel.fromMap(e)).toList();
    }
  }

  @override
  Future<Rooms> getRoomById(String id) async {
    final remoteData = await remote.fetchRoomsById(id);
    return RoomsModel.fromMap(remoteData);
  }

  @override
  Future<void> setRooms(
    String promsId,
    String name,
    int capacity,
    String campusId,
  ) async {
    await remote.createRoom(promsId, name, campusId, capacity);
  }

  @override
  Future<void> updateRooms(
    String id,
    String promsId,
    String? name,
    int? capacity,
    String? campusId,
  ) async {
    {
      await remote.updateRoom(id, promsId, name, capacity, campusId);
    }
  }

  @override
  Future<void> deleteRooms(String id) async {
    await remote.deleteRoom(id);
  }
}
