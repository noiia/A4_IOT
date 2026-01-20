import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:a4_iot/presentation/views/home_view.dart';
import 'package:a4_iot/presentation/views/login_view.dart';
import 'package:a4_iot/pages/promo_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginView()),
        (_) => false,
      );
    }
  }

  final List<Widget> _pages = const [HomeView(), PromotionPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (index == 2) {
            // Pop-up de confirmation avant logout
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Déconnexion'),
                content: const Text(
                  'Êtes-vous sûr de vouloir vous déconnecter ?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop(false), // Ne pas se déconnecter
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop(true), // Confirmer la déconnexion
                    child: const Text('Se déconnecter'),
                  ),
                ],
              ),
            );

            if (shouldLogout == true) {
              await _logout(context);
            }
          } else {
            setState(() => _currentIndex = index);
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Promo"),
          BottomNavigationBarItem(
            icon: Icon(Icons.output, color: Colors.red),
            label: "Se déconnecter",
          ),
        ],
      ),
    );
  }
}
