import 'package:a4_iot/domain/entities/courses.dart';

abstract class CourseRepository {
  Future<List<Courses>> getCourses();
  Future<Courses> getCourseById(String id);

  Future<void> setCourses(
    String courseName,
    String instructor,
    String room,
    String reservation,
  );

  Future<void> updateCourse(
    String id,
    String? courseName,
    String? instructor,
    String? room,
    String? reservation,
  );

  Future<void> deleteCourse(String id);
}
