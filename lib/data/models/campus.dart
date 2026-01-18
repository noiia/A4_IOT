import 'package:a4_iot/domain/entities/campus.dart';

class CampusModel extends Campus {
  CampusModel({
    required super.id,
    required super.name,
    required super.city,
    required super.address,
    required super.zipCode,
    required super.createdAt,
  });

  factory CampusModel.fromMap(Map<String, dynamic> map) {
    return CampusModel(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      address: map['address'],
      zipCode: map['zip_code'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "city": city,
    "address": address,
    "zip_code": zipCode,
    "created_at": createdAt,
  };
}
