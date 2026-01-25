class Users {
  final String id;
  final String badgeId;
  final String firstName;
  final String lastName;
  final String promsId;
  final String status;
  final String avatarUrl;
  final DateTime createdAt;

  Users({
    required this.id,
    required this.badgeId,
    required this.firstName,
    required this.lastName,
    required this.promsId,
    required this.status,
    required this.avatarUrl,
    required this.createdAt,
  });
}

class HomeUsers {
  final String id;
  final String badgeId;
  final String firstName;
  final String lastName;
  final String status;
  final String avatarUrl;
  final String promsName;
  final String campusName;
  final DateTime? lastPointing;

  HomeUsers({
    required this.id,
    required this.badgeId,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.avatarUrl,
    required this.promsName,
    required this.campusName,
    required this.lastPointing,
  });
}
