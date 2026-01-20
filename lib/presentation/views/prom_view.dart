import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/entities/proms.dart';
import 'package:a4_iot/presentation/controllers/proms.dart';
import 'package:a4_iot/presentation/controllers/users.dart'; // Import crucial !
import 'package:a4_iot/presentation/widget/student_row_item.dart';
import 'package:flutter_riverpod/legacy.dart';
// Pour allPromsProvider
// Pour allUsersProvider

// Définition correcte du StateProvider
final hiddenPromsProvider = StateProvider<Set<String>>((ref) => <String>{});

// Provider filtré
final filteredPromsProvider = FutureProvider<List<Proms>>((ref) async {
  final currentUser = await ref.watch(usersProvider.future);
  final allProms = await ref.watch(allPromsProvider.future);

  if (currentUser.status != 'admin') {
    return allProms.where((p) => p.id == currentUser.promsId).toList();
  }
  return allProms;
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
    // ... Le reste de votre code build est correct ...
    // Je remets juste le début pour le contexte
    final userAsync = ref.watch(usersProvider);
    final promsAsync = ref.watch(filteredPromsProvider);

    // ... (votre code Scaffold existant)
    return Scaffold(
      appBar: AppBar(title: const Text('Promotions'), elevation: 2),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Erreur user: $e")),
        data: (currentUser) {
          final isAdmin = currentUser.status == 'admin';
          return promsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Erreur proms: $e")),
            data: (promsList) {
              // ... Votre logique d'affichage (Row, ListView, etc.)

              // Exemple de correction pour l'affichage de la liste
              final hiddenProms = ref.watch(
                hiddenPromsProvider,
              ); // Utilisation correcte
              // ...

              // Pour le buildStudentList, voir ci-dessous
              return Row(
                children: [
                  // ... Partie gauche ...
                  Expanded(
                    child: _selectedPromsId == null
                        ? const Center(child: Text("Sélectionnez une promo"))
                        : _buildStudentList(_selectedPromsId!),
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
    // Appel correct au provider importé depuis users.dart
    final studentsAsync = ref.watch(studentsByPromsIdProvider(promsId));
    final selectedProms = ref.watch(promsByIdProvider(promsId));

    return selectedProms.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Erreur : $e")),
      data: (proms) {
        return Column(
          children: [
            // ... Header avec le nom de la promo ...
            Expanded(
              child: studentsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text("Erreur étudiants : $e")),
                data: (students) {
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      return StudentRowItem(
                        firstName: students[index].firstName,
                        lastName: students[index].lastName,
                        avatarUrl: students[index].avatarUrl,
                        isPresent: true, // TODO: Logique de présence
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
