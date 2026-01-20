import 'package:a4_iot/domain/entities/courses.dart';

class CoursesModel extends Courses {
  CoursesModel({
    required super.id,
    required super.courseName,
    required super.instructorId,
    required super.roomId,
    required super.reservationId,
    required super.createdAt,
  });

  factory CoursesModel.fromMap(Map<String, dynamic> map) {
    return CoursesModel(
      id: map['id'],
      courseName: map['course_name'],
      instructorId: map['instructor_id'],
      roomId: map['room_id'],
      reservationId: map['reservation_id'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "course_name": courseName,
    "instructor_id": instructorId,
    "room_id": roomId,
    "reservation_id": reservationId,
    "created_at": createdAt,
  };
}
