import 'package:a4_iot/domain/entities/rooms.dart';

abstract class RoomsRepository {
  Future<List<Rooms>> getRooms();
  Future<Rooms> getRoomById(String id);

  Future<void> setRooms(
    String promsId,
    String name,
    int capacity,
    String campusId,
  );

  Future<void> updateRooms(
    String id,
    String promsId,
    String? name,
    int? capacity,
    String? campusId,
  );

  Future<void> deleteRooms(String id);
}
