import 'package:hive/hive.dart';

class CampusLocalDatasource {
  static const boxName = "courses";

  Future<void> cacheCampus(List<Map<String, dynamic>> courses) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", courses);
  }

  Future<List<Map<String, dynamic>>> getCachedCampus() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }
}
