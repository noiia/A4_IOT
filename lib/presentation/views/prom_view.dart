import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/entities/proms.dart';
import 'package:a4_iot/presentation/controllers/proms.dart';
import 'package:a4_iot/presentation/controllers/users.dart';
import 'package:a4_iot/presentation/widget/student_row_item.dart';

final filteredPromsProvider = FutureProvider<List<Proms>>((ref) async {
  final currentUser = await ref.watch(usersProvider.future);
  final allProms = await ref.watch(allPromsProvider.future);

  if (currentUser.status == 'teacher' || currentUser.status == 'admin') {
    return allProms;
  }

  return allProms.where((p) => p.id == currentUser.promsId).toList();
});

class PromsPageView extends ConsumerStatefulWidget {
  const PromsPageView({super.key});

  @override
  ConsumerState<PromsPageView> createState() => _PromsPageViewState();
}

class _PromsPageViewState extends ConsumerState<PromsPageView> {
  String? _selectedPromsId;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(usersProvider);
    final promsAsync = ref.watch(filteredPromsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Promotions'), elevation: 2),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(
          child: Text("Erreur user: $e"),
        ), // Affiche l'erreur si null check fail
        data: (currentUser) {
          final isStaff =
              currentUser.status == 'teacher' || currentUser.status == 'admin';

          return promsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Erreur proms: $e")),
            data: (promsList) {
              // Détermination de l'ID actif
              String? activePromsId;

              if (isStaff) {
                // Pour un prof, c'est celui qu'il a sélectionné
                activePromsId = _selectedPromsId;

                // Optionnel : Sélectionner le premier par défaut si rien n'est choisi
                if (activePromsId == null && promsList.isNotEmpty) {
                  // On évite le setState ici, on le gère juste pour l'affichage local
                  // Ou on laisse null pour forcer la sélection
                }
              } else {
                // Pour un étudiant, c'est FORCÉMENT sa promo
                activePromsId = currentUser.promsId;
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- MENU GAUCHE (Seulement pour Staff) ---
                  if (isStaff)
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: ListView.separated(
                        itemCount: promsList.length,
                        separatorBuilder: (c, i) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final promo = promsList[index];
                          final isSelected = promo.id == _selectedPromsId;

                          return ListTile(
                            title: Text(promo.name),
                            selected: isSelected,
                            selectedTileColor: Colors.blue.withOpacity(0.1),
                            onTap: () {
                              setState(() {
                                _selectedPromsId = promo.id;
                              });
                            },
                          );
                        },
                      ),
                    ),

                  // --- CONTENU DROITE ---
                  Expanded(
                    child: activePromsId == null || activePromsId.isEmpty
                        ? const Center(
                            child: Text(
                              "Veuillez sélectionner une promotion",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : _buildStudentList(activePromsId),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStudentList(String promsId) {
    // Récupère TOUS les étudiants de cette promo
    final studentsAsync = ref.watch(studentsByPromsIdProvider(promsId));
    final currentPromAsync = ref.watch(promsByIdProvider(promsId));

    return currentPromAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Erreur promo : $e")),
      data: (proms) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Text(
                "Classe : ${proms.name}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: studentsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text("Erreur liste : $e")),
                data: (students) {
                  if (students.isEmpty) {
                    return const Center(child: Text("Aucun étudiant trouvé."));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final s = students[index];
                      // Filtrage visuel : n'afficher que les étudiants (pas les profs s'ils ont cet ID)
                      if (s.status == 'teacher' || s.status == 'admin') {
                        return const SizedBox.shrink();
                      }

                      return StudentRowItem(
                        firstName: s.firstName,
                        lastName: s.lastName,
                        avatarUrl: s.avatarUrl,
                        isPresent: true, // TODO: Logique réelle
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
