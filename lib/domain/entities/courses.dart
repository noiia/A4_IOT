class Courses {
  final String id;
  final String courseName;
  final String instructor;
  final String room;
  final String reservation;
  final DateTime createdAt;

  Courses({
    required this.id,
    required this.courseName,
    required this.instructor,
    required this.room,
    required this.reservation,
    required this.createdAt,
  });
}
