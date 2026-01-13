import 'package:flutter/material.dart';
import 'package:a4_iot/widget/profile_card.dart';

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
      appBar: AppBar(
        title: const Text("Promotion CESI 2026"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockStudents.length,
        itemBuilder: (context, index) {
          final student = mockStudents[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ProfileCard(
              firstName: student['firstName']!,
              lastName: student['lastName']!,
              status: student['status']!,
              proms: student['proms']!,
              campus: student['campus']!,
              avatarUrl: student['avatarUrl']!,
            ),
          );
        },
      ),
    );
  }
}
