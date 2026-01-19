import 'package:a4_iot/domain/entities/proms.dart';

class PromsModel extends Proms {
  PromsModel({
    required super.id,
    required super.name,
    required super.campusId,
    required super.createdAt,
  });

  factory PromsModel.fromMap(Map<String, dynamic> map) {
    return PromsModel(
      id: map['id'],
      name: map['name'],
      campusId: map['campus_id'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "campus_id": campusId,
    "created_at": createdAt,
  };
}
