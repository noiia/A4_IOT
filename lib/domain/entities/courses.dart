class Courses {
  final String id;
  final String courseName;
  final String instructorId;
  final String roomId;
  final String reservationId;
  final DateTime createdAt;

  Courses({
    required this.id,
    required this.courseName,
    required this.instructorId,
    required this.roomId,
    required this.reservationId,
    required this.createdAt,
  });
}
