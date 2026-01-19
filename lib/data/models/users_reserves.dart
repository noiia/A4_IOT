import 'package:a4_iot/domain/entities/users_reserves.dart';

class UsersReservesModel extends UsersReserves {
  UsersReservesModel({
    required super.id,
    required super.userId,
    required super.reservationId,
    required super.createdAt,
  });

  factory UsersReservesModel.fromMap(Map<String, dynamic> map) {
    return UsersReservesModel(
      id: map['id'],
      userId: map['user_id'],
      reservationId: map['reservation_id'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "reservation_id": reservationId,
    "created_at": createdAt,
  };
}
