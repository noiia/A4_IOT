import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Future<void> cacheUser(Map<String, dynamic> user) async {
    final box = await Hive.openBox(boxName);
    await box.put("currentUser", user);
  }

  Future<Map<String, dynamic>?> getCachedUser() async {
    final box = await Hive.openBox(boxName);
    final data = box.get("currentUser");
    if (data == null) return null;

    return Map<String, dynamic>.from(data);
  }
}

Future<void> saveRefreshToken(String refreshToken) async {
  var box = await Hive.openBox('userBox');
  await box.put('refreshToken', refreshToken);
}

Future<String?> getRefreshToken() async {
  var box = await Hive.openBox('userBox');
  return box.get('refreshToken');
}

Future<void> restoreSession() async {
  final refreshToken = await getRefreshToken();
  if (refreshToken != null) {
    await Supabase.instance.client.auth.setSession(refreshToken);
  }
}
