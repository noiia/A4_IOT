import 'package:flutter/material.dart';
import 'package:a4_iot/domain/entities/courses.dart';
import 'package:intl/intl.dart';

class CourseList extends StatelessWidget {
  final List<HomeCourses> courses;
  const CourseList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return ListTile(
            title: Text(course.courseName),

            subtitle: Text(
              '${course.room} - ${course.instructor} - ${DateFormat('yyyy-MM-dd HH:mm').format(course.reservationStart)}, à ${DateFormat('yyyy-MM-dd HH:mm').format(course.reservationEnd)}',
            ),
          );
        },
      ),
    );
  }
}
