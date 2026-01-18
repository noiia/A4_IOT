import 'package:a4_iot/domain/entities/reservations.dart';

class ReservationsModel extends Reservations {
  ReservationsModel({
    required super.id,
    required super.usersReserves,
    required super.starts,
    required super.ends,
  });

  factory ReservationsModel.fromMap(Map<String, dynamic> map) {
    return ReservationsModel(
      id: map['id'],
      usersReserves: map['users_reserves'],
      starts: map['starts'],
      ends: map['ends'],
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "users_reserves": usersReserves,
    "starts": starts,
    "ends": ends,
  };
}
