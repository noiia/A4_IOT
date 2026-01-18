import 'package:hive/hive.dart';

class ReservationsLocalDatasource {
  static const boxName = "reservations";

  Future<void> cacheReservations(
    List<Map<String, dynamic>> reservations,
  ) async {
    final box = await Hive.openBox(boxName);
    await box.put("list", reservations);
  }

  Future<List<Map<String, dynamic>>> getCachedReservations() async {
    final box = await Hive.openBox(boxName);
    return List<Map<String, dynamic>>.from(box.get("list") ?? []);
  }
}
