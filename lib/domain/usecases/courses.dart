import 'package:a4_iot/domain/entities/courses.dart';
import 'package:a4_iot/domain/repositories/courses.dart';

class GetCourses {
  final CourseRepository repository;

  GetCourses(this.repository);

  Future<List<Courses>> call(String id) {
    return repository.getCourses();
  }
}

class GetCoursesById {
  final CourseRepository repository;

  GetCoursesById(this.repository);

  Future<Courses> call(String id) {
    return repository.getCourseById(id);
  }
}

class GetCoursesByIds {
  final CourseRepository repository;

  GetCoursesByIds(this.repository);

  Future<List<Courses>> call(List<String> ids) {
    return repository.getCoursesByIds(ids);
  }
}

class GetCoursesByReservationIds {
  final CourseRepository repository;

  GetCoursesByReservationIds(this.repository);

  Future<List<Courses>> call(List<String> ids) {
    return repository.getCoursesByReservationIds(ids);
  }
}

class CreateCourses {
  final CourseRepository repository;

  CreateCourses(this.repository);

  Future<void> call({
    required String courseName,
    required String instructor,
    required String room,
    required String reservation,
  }) {
    return repository.setCourses(courseName, instructor, room, reservation);
  }
}

class UpdateCourses {
  final CourseRepository repository;

  UpdateCourses(this.repository);

  Future<void> call({
    required String id,
    required String courseName,
    required String instructor,
    required String room,
    required String reservation,
  }) {
    return repository.updateCourse(
      id,
      courseName,
      instructor,
      room,
      reservation,
    );
  }
}

class DeleteCourses {
  final CourseRepository repository;

  DeleteCourses(this.repository);

  Future<void> call(String id) {
    return repository.deleteCourse(id);
  }
}
