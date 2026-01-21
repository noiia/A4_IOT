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

class HomeCoursesModel extends HomeCourses {
  HomeCoursesModel({
    required super.id,
    required super.courseName,
    required super.instructor,
    required super.room,
    required super.reservationStart,
    required super.reservationEnd,
  });

  factory HomeCoursesModel.fromMap(
    Map<String, dynamic> reservationMap,
    Map<String, dynamic> coursesMap,
  ) {
    return HomeCoursesModel(
      id: reservationMap['id'],
      courseName: coursesMap['course_name'] ?? 'Inconnu',
      instructor: coursesMap['users'] != null
          ? "${coursesMap['users']['first_name']} ${coursesMap['users']['last_name']}"
          : 'Inconnu',
      room: coursesMap['rooms']?['name'] ?? 'Inconnu',
      reservationStart: DateTime.parse(reservationMap['start'] as String),
      reservationEnd: DateTime.parse(reservationMap['ends'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "course_name": courseName,
    "instructor": instructor,
    "rooms": room,
    "reservation_start": reservationStart,
    "reservation_end": reservationEnd,
  };
}
