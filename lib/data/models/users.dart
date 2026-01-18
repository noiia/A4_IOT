import 'package:a4_iot/domain/entities/users.dart';

class UsersModel extends Users {
  UsersModel({
    required super.id,
    required super.badgeId,
    required super.firstName,
    required super.lastName,
    required super.promsId,
    required super.status,
    required super.avatarUrl,
  });

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'],
      badgeId: map['badge_id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      status: map['status'],
      avatarUrl: map['avatar_url'],
      promsId: map['proms_id'],
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "badge_id": badgeId,
    "first_name": firstName,
    "last_name": lastName,
    "status": status,
    "avatar_url": lastName,
    "proms_id": promsId,
  };
}
