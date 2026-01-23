import 'package:a4_iot/domain/entities/pointing.dart';

class PointingModel extends Pointing {
  PointingModel({
    required super.id,
    required super.userBadgeId,
    required super.createdAt,
  });

  factory PointingModel.fromMap(Map<String, dynamic> map) {
    return PointingModel(
      id: map['id'],
      userBadgeId: map['user_badge_id'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_badge_id": userBadgeId,
    "created_at": createdAt,
  };
}
