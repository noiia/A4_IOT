import 'proms.dart';

class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String status;
  final String avatarUrl;
  final String proms;
  final String campus;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.avatarUrl,
    required this.proms,
    required this.campus,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      status: map['status'],
      avatarUrl: map['avatar_url'],
      proms: Proms.fromMap(map['name']).toString(),
      campus: Proms.fromMap(map['city']).toString(),
    );
  }
}
