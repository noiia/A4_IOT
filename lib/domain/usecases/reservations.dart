import 'package:a4_iot/domain/entities/reservations.dart';
import 'package:a4_iot/domain/repositories/reservations.dart';

class GetReservations {
  final ReservationsRepository repository;

  GetReservations(this.repository);

  Future<List<Reservations>> call(String id) {
    return repository.getReservations();
  }
}

class GetReservationsById {
  final ReservationsRepository repository;

  GetReservationsById(this.repository);

  Future<List<Reservations>> call(String id) {
    return repository.getReservationsById(id);
  }
}

class GetReservationsByIds {
  final ReservationsRepository repository;

  GetReservationsByIds(this.repository);

  Future<List<Reservations>> call(List<String> ids) {
    return repository.getReservationsByIds(ids);
  }
}

class CreateReservations {
  final ReservationsRepository repository;

  CreateReservations(this.repository);

  Future<void> call({
    required String usersReserves,
    required DateTime starts,
    required DateTime ends,
  }) {
    return repository.setReservations(usersReserves, starts, ends);
  }
}

class UpdateReservations {
  final ReservationsRepository repository;

  UpdateReservations(this.repository);

  Future<void> call({
    required String id,
    required String usersReserves,
    required DateTime starts,
    required DateTime ends,
  }) {
    return repository.updateReservations(id, usersReserves, starts, ends);
  }
}

class DeleteReservations {
  final ReservationsRepository repository;

  DeleteReservations(this.repository);

  Future<void> call(String id) {
    return repository.deleteReservations(id);
  }
}
