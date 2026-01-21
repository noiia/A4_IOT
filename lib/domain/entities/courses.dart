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

class HomeCourses {
  final String id;
  final String courseName;
  final String instructor;
  final String room;
  final DateTime reservationStart;
  final DateTime reservationEnd;
  HomeCourses({
    required this.id,
    required this.courseName,
    required this.instructor,
    required this.room,
    required this.reservationStart,
    required this.reservationEnd,
  });
}
