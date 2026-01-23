import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/entities/campus.dart';
import 'package:a4_iot/domain/entities/courses.dart';
import 'package:a4_iot/domain/entities/users.dart';
import 'package:a4_iot/domain/entities/proms.dart';
import 'package:a4_iot/presentation/controllers/courses.dart';
import 'package:a4_iot/presentation/controllers/users.dart';
import 'package:a4_iot/presentation/controllers/proms.dart';
import 'package:a4_iot/presentation/controllers/campus.dart';
import 'package:a4_iot/presentation/widget/course_list.dart';
import 'package:a4_iot/presentation/widget/profile_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  Widget _buildPage(
    Users user,
    Proms proms,
    List<HomeCourses> courses,
    Campus campus,
  ) {
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
                      proms: proms.name,
                      campus: campus.name,
                      avatarUrl: user.avatarUrl,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 500,
                    height: 450,
                    child: courses.isEmpty
                        ? const Center(
                            child: Text(
                              "Aucun cours pour le moment",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : CourseList(courses: courses),
                  ),
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
    final userAsync = ref.watch(usersProvider);

    return Scaffold(
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Erreur user : $e")),
        data: (user) {
          final promsAsync = ref.watch(promsByIdProvider(user.promsId));
          return promsAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.red),
            ),
            error: (e, _) => Center(child: Text("Erreur proms : $e")),
            data: (proms) {
              final campusAsync = ref.watch(campusByIdProvider(proms.campusId));
              return campusAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
                error: (e, _) => Center(child: Text("Erreur campus : $e")),
                data: (campus) {
                  final coursesDataAsync = ref.watch(
                    homeCoursesIdsProvider(user.badgeId),
                  );
                  return coursesDataAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    ),
                    error: (e, _) => Center(child: Text("Erreur cours : $e")),
                    data: (coursesData) =>
                        _buildPage(user, proms, coursesData, campus),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
