import 'package:hive/hive.dart';

class CourseLocalDatasource {
  static const boxName = "courses";

  Future<void> cacheCourses(List<Map<String, dynamic>> courses) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", courses);
  }

  Future<List<Map<String, dynamic>>> getCachedCourses() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }

  Future<void> cacheUserCourses(List<Map<String, dynamic>> courses) async {
    final box = await Hive.openBox(boxName);
    await box.put("userCourses", courses);
  }

  Future<List<Map<String, dynamic>>?> getCachedUserCourses() async {
    final box = await Hive.openBox(boxName);
    final data = box.get("userCourses");
    if (data == null) return null;

    return List<Map<String, dynamic>>.from(
      (data as List).map((e) => Map<String, dynamic>.from(e)),
    );
  }
}
