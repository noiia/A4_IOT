import 'package:a4_iot/domain/entities/reservations.dart';

abstract class ReservationsRepository {
  Future<List<Reservations>> getReservations();
  Future<List<Reservations>> getReservationsById(String id);
  Future<List<Reservations>> getReservationsByIds(List<String> ids);
  Future<List<Reservations>> getReservationsFromUsersReservesByUserId(
    String id,
  );

  Future<void> setReservations(
    String usersReserves,
    DateTime start,
    DateTime ends,
  );

  Future<void> updateReservations(
    String id,
    String? usersReserves,
    DateTime? start,
    DateTime? ends,
  );

  Future<void> deleteReservations(String id);
}
