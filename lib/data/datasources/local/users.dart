import 'package:hive/hive.dart';

class UsersLocalDatasource {
  static const boxName = "users";

  Future<void> cacheUsers(List<Map<String, dynamic>> users) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", users);
  }

  Future<List<Map<String, dynamic>>> getCachedUsers() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }
}
