import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// --- IMPORTS EXISTANTS ---
import 'package:a4_iot/presentation/controllers/users.dart';
import 'package:a4_iot/presentation/views/home_view.dart';
import 'package:a4_iot/presentation/views/login_view.dart';
import 'package:a4_iot/presentation/views/prom_view.dart';
import 'package:a4_iot/utils/ble_listening.dart';

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
  final List<Widget> _pages = const [HomeView(), PromsPageView()];

  @override
  void initState() {
    super.initState();
    // ⚡ Connexion automatique au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("🏁 Initialisation : Recherche auto de 'MyDoorLock'...");
      ref.read(bleControllerProvider).startAutoConnect('MyDoorLock');
    });
  }

  Future<void> _logout(BuildContext context) async {
    // Coupe la connexion BLE proprement avant de quitter
    await ref.read(bleControllerProvider).disconnect();

    await Supabase.instance.client.auth.signOut();
    ref.invalidate(usersProvider);
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginView()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Écoute l'état de connexion pour mettre à jour l'UI
    final isConnected = ref.watch(isConnectedProvider);
    final controller = ref.read(bleControllerProvider);

    return Scaffold(
      // Barre optionnelle pour confirmer la connexion visuellement
      appBar: isConnected
          ? AppBar(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bluetooth_connected, size: 20),
                  SizedBox(width: 8),
                  Text("Porte Connectée", style: TextStyle(fontSize: 16)),
                ],
              ),
              backgroundColor: Colors.greenAccent.withOpacity(0.8),
              centerTitle: true,
              toolbarHeight: 40,
              automaticallyImplyLeading: false, // Pas de flèche retour
            )
          : null,

      body: Stack(
        children: [
          // Les pages de l'application (Home / Proms)
          _pages[_currentIndex],

          // BOUTON FLOTTANT "OUVRIR" (Visible uniquement si connecté)
          if (isConnected)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton.extended(
                heroTag:
                    "ble_unlock_fab", // Tag unique pour éviter les conflits d'animation
                onPressed: () async {
                  // Appel de la commande 'open'
                  await controller.sendOpenCommand();

                  // Feedback tactile et visuel
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("🚀 Commande d'ouverture envoyée !"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                backgroundColor: Colors.orange,
                icon: const Icon(Icons.lock_open, size: 28),
                label: const Text(
                  "OUVRIR PORTE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                elevation: 6,
              ),
            ),
        ],
      ),

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
            // Navigation normale
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Promo"),
          BottomNavigationBarItem(
            icon: Icon(Icons.output, color: Colors.red),
            label: "Déconnexion",
          ),
        ],
      ),
    );
  }
}
