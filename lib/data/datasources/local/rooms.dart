import 'package:hive/hive.dart';

class RoomsLocalDatasource {
  static const boxName = "rooms";

  Future<void> cacheRooms(List<Map<String, dynamic>> rooms) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", rooms);
  }

  Future<List<Map<String, dynamic>>> getCachedRooms() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }
}
