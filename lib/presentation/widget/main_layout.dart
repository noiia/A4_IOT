import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:a4_iot/presentation/controllers/users.dart';
import 'package:a4_iot/presentation/views/home_view.dart';
import 'package:a4_iot/presentation/views/login_view.dart';
import 'package:a4_iot/presentation/views/prom_view.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({super.key});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

Future<bool> hasInternet() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  int _currentIndex = 0;

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    ref.invalidate(usersProvider);

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginView()),
        (_) => false,
      );
    }
  }

  final List<Widget> _pages = const [HomeView(), PromsPageView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (index == 2) {
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Déconnexion'),
                content: const Text(
                  'Êtes-vous sûr de vouloir vous déconnecter ?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
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
