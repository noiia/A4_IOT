import 'package:hive/hive.dart';

class PointingLocalDatasource {
  static const boxName = "pointing";

  Future<void> cacheLastUsersPointing(Map<String, dynamic> pointing) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", pointing);
  }

  Future<List<Map<String, dynamic>>> getCachedLastUsersPointing() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }

  Future<void> cachePointings(List<Map<String, dynamic>> pointing) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", pointing);
  }

  Future<List<Map<String, dynamic>>> getCachedPointings() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }

  Future<void> cacheUserPointings(List<Map<String, dynamic>> pointing) async {
    final box = await Hive.openBox(boxName);
    await box.put("userPointing", pointing);
  }

  Future<List<Map<String, dynamic>>?> getCachedUserPointings() async {
    final box = await Hive.openBox(boxName);
    final data = box.get("userPointing");
    if (data == null) return null;

    return List<Map<String, dynamic>>.from(data);
  }
}
