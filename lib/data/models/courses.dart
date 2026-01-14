class Courses {
  String courseName;
  String instructor;
  String room;
  String schedule;

  Courses({
    required this.courseName,
    required this.instructor,
    required this.room,
    required this.schedule,
  });

  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
      courseName: map['course_name'],
      instructor: map['instructor'],
      room: map['room'],
      schedule: map['schedule'],
    );
  }
}
