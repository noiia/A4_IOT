import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: PromotionPage()),
  );
}

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key});

  // Mock des données (20 étudiants)
  final List<Map<String, String>> mockStudents = const [
    {
      "firstName": "Lucas",
      "lastName": "Martin",
      "status": "Délégué",
      "proms": "CESI 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=11",
    },
    {
      "firstName": "Camille",
      "lastName": "Bernard",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=5",
    },
    {
      "firstName": "Léa",
      "lastName": "Dubois",
      "status": "Étudiant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=9",
    },
    {
      "firstName": "Thomas",
      "lastName": "Petit",
      "status": "Recherche de stage",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=3",
    },
    {
      "firstName": "Manon",
      "lastName": "Robert",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=20",
    },
    {
      "firstName": "Hugo",
      "lastName": "Richard",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=12",
    },
    {
      "firstName": "Chloé",
      "lastName": "Durand",
      "status": "Délégué",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=1",
    },
    {
      "firstName": "Nathan",
      "lastName": "Leroy",
      "status": "Étudiant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=8",
    },
    {
      "firstName": "Emma",
      "lastName": "Moreau",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=24",
    },
    {
      "firstName": "Enzo",
      "lastName": "Simon",
      "status": "Recherche de stage",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=53",
    },
    {
      "firstName": "Sarah",
      "lastName": "Laurent",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=32",
    },
    {
      "firstName": "Gabriel",
      "lastName": "Lefebvre",
      "status": "Étudiant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=51",
    },
    {
      "firstName": "Jade",
      "lastName": "Michel",
      "status": "Délégué",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=44",
    },
    {
      "firstName": "Louis",
      "lastName": "Garcia",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=59",
    },
    {
      "firstName": "Louise",
      "lastName": "David",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=41",
    },
    {
      "firstName": "Arthur",
      "lastName": "Bertrand",
      "status": "Étudiant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=60",
    },
    {
      "firstName": "Alice",
      "lastName": "Roux",
      "status": "Recherche de stage",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=42",
    },
    {
      "firstName": "Raphaël",
      "lastName": "Vincent",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=68",
    },
    {
      "firstName": "Lina",
      "lastName": "Fournier",
      "status": "Délégué",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=35",
    },
    {
      "firstName": "Jules",
      "lastName": "Morel",
      "status": "Alternant",
      "proms": "Cesi Fisa a4 2026",
      "campus": "Reims",
      "avatarUrl": "https://i.pravatar.cc/150?img=70",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors
          .grey[50], // Fond légèrement grisé pour faire ressortir les lignes
      appBar: AppBar(
        elevation: 0,
        title: const Text("Promotion CESI 2026"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: mockStudents.length,
        itemBuilder: (context, index) {
          final student = mockStudents[index];

          // --- LOGIQUE DE SIMULATION ---
          // On simule une absence pour 1 étudiant sur 5 environ
          // (dans votre vraie app, cela viendra de votre BDD/API)
          final bool simulatedIsPresent = index % 5 != 0;

          return StudentRowItem(
            firstName: student['firstName']!,
            lastName: student['lastName']!,
            avatarUrl: student['avatarUrl']!,
            isPresent: simulatedIsPresent,
          );
        },
      ),
    );
  }
}

// --- NOUVEAU WIDGET : Ligne compacte ---
class StudentRowItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final bool isPresent;

  const StudentRowItem({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.isPresent,
  });

  @override
  Widget build(BuildContext context) {
    // Définition des couleurs selon le statut
    final statusColor = isPresent ? Colors.green[700]! : Colors.red[700]!;
    final statusBgColor = isPresent ? Colors.green[50]! : Colors.red[50]!;
    final statusText = isPresent ? "Présent" : "Absent";
    final statusIcon = isPresent ? Icons.check_circle : Icons.cancel;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Bordure subtile qui change de couleur selon le statut
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- GAUCHE : Avatar + Nom ---
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(avatarUrl),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$firstName $lastName",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(statusIcon, color: statusColor, size: 18),
                const SizedBox(width: 8),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
