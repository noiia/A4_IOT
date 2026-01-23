import 'package:hive/hive.dart';

class PromsLocalDatasource {
  static const boxName = "proms";

  Future<void> cacheProms(List<Map<String, dynamic>> proms) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", proms);
  }

  Future<List<Map<String, dynamic>>> getCachedProms() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }

  Future<void> cacheUserProms(Map<String, dynamic> proms) async {
    final box = await Hive.openBox(boxName);
    await box.put("userProms", proms);
  }

  Future<Map<String, dynamic>?> getCachedUserProm() async {
    final box = await Hive.openBox(boxName);
    final data = box.get("userProms");
    if (data == null) return null;

    return Map<String, dynamic>.from(data);
  }
}
