import 'package:a4_iot/domain/entities/rooms.dart';

class RoomsModel extends Rooms {
  RoomsModel({
    required super.id,
    required super.promsId,
    required super.name,
    required super.campus,
    required super.capacity,
    required super.createdAt,
  });

  factory RoomsModel.fromMap(Map<String, dynamic> map) {
    return RoomsModel(
      id: map['id'],
      promsId: map['proms_id'],
      name: map['name'],
      campus: map['campus'],
      capacity: map['capacity'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "proms_id": promsId,
    "name": name,
    "campus": campus,
    "capacity": capacity,
    "created_at": createdAt,
  };
}
