import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/entities/courses.dart';
import 'package:a4_iot/domain/entities/users.dart';
import 'package:a4_iot/presentation/controllers/courses.dart';
import 'package:a4_iot/presentation/controllers/users.dart';
import 'package:a4_iot/presentation/views/login_view.dart';
import 'package:a4_iot/presentation/widget/course_list.dart';
import 'package:a4_iot/presentation/widget/fullscreen_button.dart';
import 'package:a4_iot/presentation/widget/profile_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginView()),
        (_) => false,
      );
    }
  }

  Widget _buildPage(Users user, List<Courses> courses) {
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
                      firstName: user.firstName,
                      lastName: user.lastName,
                      status: user.status,
                      proms: 'user.promsId.name',
                      campus: 'user.promsId.campus_id.name',
                      avatarUrl: user.avatarUrl,
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
    final coursesAsync = ref.watch(coursesProvider);
    final userAsync = ref.watch(usersProvider);

    return Scaffold(
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Erreur user : $e")),
        data: (user) {
          return coursesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Erreur cours : $e")),
            data: (courses) => _buildPage(user, courses),
          );
        },
      ),
    );
  }
}
