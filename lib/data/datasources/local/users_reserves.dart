import 'package:hive/hive.dart';

class UsersReservesLocalDatasource {
  static const boxName = "users_reserves";

  Future<void> cacheUsersReserves(
    List<Map<String, dynamic>> usersReserves,
  ) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", usersReserves);
  }

  Future<List<Map<String, dynamic>>> getCachedUsersReserves() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }
}
