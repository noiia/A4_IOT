import 'package:a4_iot/types/course_list.dart';
import 'package:flutter/material.dart';
import 'package:a4_iot/widget/profile_card.dart';
import 'package:a4_iot/widget/course_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _mobileLayout();
          // if (constraints.maxWidth < 700) {
          //   return _mobileLayout();
          // } else {
          //   return _desktopLayout();
          // }
        },
      ),
    );
  }

  Widget _mobileLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 500,
                child: ProfileCard(
                  firstName: "Edwin",
                  lastName: "Lecomte",
                  status: "Etudiant",
                  proms: "FISA A4",
                  campus: "Reims",
                  avatarUrl: "https://i.pravatar.cc/300",
                ),
              ),
              SizedBox(
                width: 500,
                height: 450,
                child: CourseList(
                  courses: [
                    CourseListType(
                      courseName: 'Course 1',
                      instructor: 'Instructor 1',
                      room: 'Room 1',
                      schedule: 'Schedule 1',
                    ),
                    CourseListType(
                      courseName: 'Course 1',
                      instructor: 'Instructor 1',
                      room: 'Room 1',
                      schedule: 'Schedule 1',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _desktopLayout() {
  //   return const Center(
  //     child: SizedBox(
  //       width: 500,
  //       child: ProfileCard(
  //         firstName: "Edwin",
  //         lastName: "Lecomte",
  //         status: "Etudiant",
  //         proms: "FISA A4",
  //         campus: "Reims",
  //         avatarUrl: "https://i.pravatar.cc/300",
  //       ),
  //     ),
  //   );
  // }
}
