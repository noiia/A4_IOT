import 'package:a4_iot/domain/entities/reservations.dart';

class ReservationsModel extends Reservations {
  ReservationsModel({
    required super.id,
    required super.starts,
    required super.ends,
    required super.createdAt,
  });

  factory ReservationsModel.fromMap(Map<String, dynamic> map) {
    return ReservationsModel(
      id: map['id'],
      starts: DateTime.parse(map['start'] as String),
      ends: DateTime.parse(map['ends'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "start": starts,
    "ends": ends,
    "created_at": createdAt,
  };
}
