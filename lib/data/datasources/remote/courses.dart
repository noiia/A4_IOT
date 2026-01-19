import 'package:supabase_flutter/supabase_flutter.dart';

class CourseRemoteDatasource {
  final SupabaseClient client;

  CourseRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> fetchCourses() async {
    return await client.from('courses').select();
  }

  Future<Map<String, dynamic>> fetchCourseById(String id) async {
    return await client.from('courses').select().eq('id', id).single();
  }

  Future<List<Map<String, dynamic>>> fetchCoursesByIds(List<String> ids) async {
    if (ids.isEmpty) {
      return [];
    }
    return await client.from('courses').select().eq('id', ids);
  }

  Future<List<Map<String, dynamic>>> fetchCoursesByReservationIds(
    List<String> ids,
  ) async {
    return await client.from('courses').select().eq('reservation_id', ids);
  }

  Future<List<Map<String, dynamic>>> fetchCoursesByInstructor(String id) async {
    final res = await client
        .from('courses')
        .select('''
        *,
        instructor:users!courses_instructor_fkey (
          badge_id,
          first_name,
          last_name,
          status,
          avatar_url,
          auth_user_id
        ),
        room:rooms (*),
        reservation:reservations (*)
      ''')
        .eq('instructor.auth_user_id', id);

    return List<Map<String, dynamic>>.from(res);
  }

  Future<List<Map<String, dynamic>>> fetchCoursesForStudent(String id) async {
    final res = await client
        .from('courses')
        .select('''
        *,
        reservation:reservations (
          *,
          users
        ),
        room:rooms (*)
      ''')
        .contains('reservation.users', [id]);

    return List<Map<String, dynamic>>.from(res);
  }

  Future<List<Map<String, dynamic>>> fetchUsersCourses(String id) async {
    final instructorCourses = await fetchCoursesByInstructor(id);

    if (instructorCourses.isNotEmpty) {
      return instructorCourses;
    }

    return await fetchCoursesForStudent(id);
  }

  Future<void> createCourse(
    String courseName,
    String instructor,
    String room,
    String reservation,
  ) async {
    return await client.from('courses').insert({
      'course_name': courseName,
      'instructor': instructor,
      'room': room,
      'reservation': reservation,
    });
  }

  Future<void> updateCourse(
    String id,
    String? courseName,
    String? instructor,
    String? room,
    String? reservation,
  ) async {
    return await client
        .from('courses')
        .update({
          'course_name': courseName,
          'instructor': instructor,
          'room': room,
          'reservation': reservation,
        })
        .eq('id', id);
  }

  Future<void> deleteCourse(String id) async {
    return await client.from('courses').delete().eq('id', id);
  }
}
