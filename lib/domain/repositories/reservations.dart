import 'package:a4_iot/domain/entities/reservations.dart';

abstract class ReservationsRepository {
  Future<List<Reservations>> getReservations();
  Future<Reservations> getReservationsById(String id);

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
