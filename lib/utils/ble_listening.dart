// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:permission_handler/permission_handler.dart';

const String SERVICE_UUID = "12345678-1234-1234-1234-123456789012";
const String CHARACTERISTIC_UUID = "87654321-4321-4321-4321-210987654321";
// --- STATE PROVIDERS ---
final isConnectedProvider = StateProvider<bool>((ref) => false);
final connectedDeviceProvider = StateProvider<BluetoothDevice?>((ref) => null);

// --- CONTROLLER ---
final bleControllerProvider = Provider<BleController>((ref) {
  return BleController(ref);
});

class BleController {
  final Ref ref;
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;

  BleController(this.ref);

  /// Tente de trouver et connecter automatiquement "MyDoorLock"
  Future<void> startAutoConnect(String targetName) async {
    // 1. Permissions
    bool permsGranted = await _requestPermissions();
    if (!permsGranted) {
      print(" Permissions manquantes pour le BLE");
      return;
    }

    // Si déjà connecté, on ne fait rien
    if (ref.read(isConnectedProvider)) {
      print("Déjà connecté");
      return;
    }

    print("Recherche automatique de '$targetName'...");

    _scanSubscription = FlutterBluePlus.scanResults.listen((results) async {
      // Cherche l'appareil cible dans les résultats
      for (ScanResult r in results) {
        if (r.device.platformName == targetName) {
          print(
            " Cible trouvée: ${r.device.platformName} (${r.device.remoteId})",
          );

          await stopScan();

          // Lancer la connexion
          await connectToDevice(r.device);
          break; // Sortir de la boucle
        }
      }
    });

    // 3. Démarrer le scan (avec filtre sur le nom pour optimiser)
    try {
      await FlutterBluePlus.startScan(
        withNames: [targetName], // Filtre natif si possible
        timeout: const Duration(seconds: 15),
      );
    } catch (e) {
      print("Erreur scan: $e");
    }
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
    await _scanSubscription?.cancel();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      print(" Tentative de connexion...");
      // autoConnect: true permet la reconnexion auto si le lien coupe (Android)
      await device.connect(
        autoConnect: false,
        timeout: const Duration(seconds: 10),
      );

      ref.read(isConnectedProvider.notifier).state = true;
      ref.read(connectedDeviceProvider.notifier).state = device;
      print(" CONNECTÉ à ${device.platformName} !");

      _connectionSubscription = device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          print("Perte de connexion");
          ref.read(isConnectedProvider.notifier).state = false;
          ref.read(connectedDeviceProvider.notifier).state = null;
        }
      });
    } catch (e) {
      print(" Échec connexion: $e");
      ref.read(isConnectedProvider.notifier).state = false;
    }
  }

  Future<void> disconnect() async {
    final device = ref.read(connectedDeviceProvider);
    if (device != null) {
      await device.disconnect();
      await _connectionSubscription?.cancel();
      ref.read(isConnectedProvider.notifier).state = false;
      ref.read(connectedDeviceProvider.notifier).state = null;
    }
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();
      return statuses.values.every((status) => status.isGranted);
    }
    return true;
  }

  Future<void> sendOpenCommand() async {
    final device = ref.read(connectedDeviceProvider);
    if (device == null) {
      print("Pas d'appareil connecté");
      return;
    }

    try {
      print(" Recherche du service...");
      // Découvrir les services
      List<BluetoothService> services = await device.discoverServices();

      BluetoothCharacteristic? targetChar;

      // Parcourir pour trouver la bonne caractéristique
      for (var service in services) {
        if (service.uuid.toString() == SERVICE_UUID) {
          for (var c in service.characteristics) {
            if (c.uuid.toString() == CHARACTERISTIC_UUID) {
              targetChar = c;
              break;
            }
          }
        }
      }

      if (targetChar != null) {
        print("Envoi de 'open'...");
        // Convertir String en bytes UTF-8
        List<int> bytes = "open".codeUnits;
        await targetChar.write(bytes);
        print("Commande envoyée !");
      } else {
        print("Caractéristique introuvable (Vérifie les UUIDs)");
      }
    } catch (e) {
      print("Erreur envoi: $e");
    }
  }
}
