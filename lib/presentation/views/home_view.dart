import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:a4_iot/data/models/courses.dart';
import 'package:a4_iot/presentation/views/login_view.dart';
import 'package:a4_iot/presentation/widget/course_list.dart';
import 'package:a4_iot/presentation/widget/fullscreen_button.dart';
import 'package:a4_iot/presentation/widget/profile_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _loading = false;
  String? _error;

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginView()),
        (_) => false,
      );
    }
  }

  Future<Map<String, dynamic>> _getProfile() async {
    final supabase = Supabase.instance.client;

    return await supabase
        .from('users')
        .select('first_name, last_name, status, avatar_url, proms(name, city)')
        .eq('auth_user_id', supabase.auth.currentUser!.id)
        .single();
  }

  Future<List<Courses>> _getCourses() async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('courses')
        .select('course_name, instructor, room, reservation')
        .eq('user_id', supabase.auth.currentUser!.id);

    final data = response as List;

    return data
        .map(
          (e) => Courses(
            courseName: e['course_name'],
            instructor: e['instructor'],
            room: e['room'],
            schedule: e['schedule'],
          ),
        )
        .toList();
  }

  Widget _buildPage(Map<String, dynamic> user, List<Courses> courses) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 500,
                    child: ProfileCard(
                      firstName: user['first_name'],
                      lastName: user['last_name'],
                      status: user['status'],
                      proms: user['proms']['name'],
                      campus: user['proms']['city'],
                      avatarUrl: user['avatar_url'],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 500,
                    height: 450,
                    child: CourseList(courses: courses),
                  ),
                  const SizedBox(height: 36),
                  FullScreenButton(name: 'Se déconnecter', function: _logout),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([_getProfile(), _getCourses()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }

          final user = snapshot.data![0] as Map<String, dynamic>;
          final courses = snapshot.data![1] as List<Courses>;

          return _buildPage(user, courses);
        },
      ),
    );
  }
}
