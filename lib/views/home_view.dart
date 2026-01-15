import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:a4_iot/types/course_list.dart';
import 'package:a4_iot/views/login_view.dart';
import 'package:a4_iot/widget/course_list.dart';
import 'package:a4_iot/widget/fullscreen_button.dart';
import 'package:a4_iot/widget/profile_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginView()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                    const SizedBox(height: 36),
                    FullScreenButton(name: 'Se déconnecter', function: _logout),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
