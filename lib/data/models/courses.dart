import 'package:a4_iot/domain/entities/courses.dart';

class CoursesModel extends Courses {
  CoursesModel({
    required super.id,
    required super.courseName,
    required super.instructor,
    required super.room,
    required super.reservation,
  });

  factory CoursesModel.fromMap(Map<String, dynamic> map) {
    return CoursesModel(
      id: map['id'],
      courseName: map['course_name'],
      instructor: map['instructor'],
      room: map['room'],
      reservation: map['reservation'],
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "course_name": courseName,
    "instructor": instructor,
    "room": room,
    "reservation": reservation,
  };
}
