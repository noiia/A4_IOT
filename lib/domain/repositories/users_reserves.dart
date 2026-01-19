import 'package:a4_iot/domain/entities/users_reserves.dart';

abstract class UsersReservesRepository {
  Future<List<UsersReserves>> getUsersReserves();
  Future<List<UsersReserves>> getUsersReservesById(String id);
  Future<List<UsersReserves>> getUsersReservesByUserId(String id);
  Future<List<UsersReserves>> getUsersReservesByReservationId(String id);

  Future<void> setUsersReserves(String userId, String reservationId);

  Future<void> updateUsersReserves(
    String id,
    String? userId,
    String? reservationId,
  );

  Future<void> deleteUsersReserves(String id);
}
