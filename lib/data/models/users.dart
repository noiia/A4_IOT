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
    required super.createdAt,
  });

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['auth_user_id'],
      badgeId: map['badge_id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      status: map['status'],
      avatarUrl: map['avatar_url'],
      promsId: map['proms_id'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "auth_user_id": id,
    "badge_id": badgeId,
    "first_name": firstName,
    "last_name": lastName,
    "status": status,
    "avatar_url": avatarUrl,
    "proms_id": promsId,
    "created_at": createdAt,
  };
}
