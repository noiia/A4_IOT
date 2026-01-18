import 'package:a4_iot/domain/entities/proms.dart';

class PromsModel extends Proms {
  PromsModel({
    required super.id,
    required super.name,
    required super.city,
    required super.createdAt,
  });

  factory PromsModel.fromMap(Map<String, dynamic> map) {
    return PromsModel(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "city": city,
    "created_at": createdAt,
  };
}
