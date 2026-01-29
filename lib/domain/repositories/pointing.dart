import 'package:a4_iot/domain/entities/pointing.dart';

abstract class PointingRepository {
  Future<Pointing> getPointingById(String id);
  Future<Pointing> getLastPointingByUserBadgeId(String userBadgeId);
  Future<List<Pointing>> getPointings();
  Future<List<Pointing>> getPointingsByUserBadgeId(String userBadgeId);

  Future<void> setPointing(String userBadgeId, DateTime dateTime);
}
