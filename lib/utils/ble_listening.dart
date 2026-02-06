// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:a4_iot/presentation/controllers/users.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

const String SERVICE_UUID = "12345678-1234-1234-1234-1234567890ab";
const String CHARACTERISTIC_UUID = "abcd1234-1234-1234-1234-abcdefabcdef";

final isConnectedProvider = StateProvider<bool>((ref) => false);
final connectedDeviceProvider = StateProvider<BluetoothDevice?>((ref) => null);

final bleControllerProvider = Provider<BleController>((ref) {
  return BleController(ref);
});

class BleController {
  final Ref ref;
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;

  BleController(this.ref);

  Future<void> startAutoConnect(String targetName) async {
    bool permsGranted = await _requestPermissions();
    if (!permsGranted) {
      print("Permissions manquantes pour le BLE");
      return;
    }

    if (ref.read(isConnectedProvider)) {
      print("Déjà connecté");
      return;
    }

    print("Recherche automatique de '$targetName'...");

    _scanSubscription = FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult r in results) {
        if (r.device.platformName == targetName) {
          print(
            "Cible trouvée: ${r.device.platformName} (${r.device.remoteId})",
          );

          await stopScan();

          await connectToDevice(r.device);
          break;
        }
      }
    });

    try {
      await FlutterBluePlus.startScan(
        withNames: [targetName],
        timeout: const Duration(seconds: 15),
      );
    } catch (e) {
      print("Erreur scan: $e");
    }
  }

  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
      await _scanSubscription?.cancel();
    } catch (e) {
      print("Erreur lors de l'arrêt du scan: $e");
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      print("Tentative de connexion...");

      await stopScan();

      await Future.delayed(const Duration(milliseconds: 200));

      await device.connect(
        autoConnect: false,
        timeout: const Duration(seconds: 10),
      );

      ref.read(isConnectedProvider.notifier).state = true;
      ref.read(connectedDeviceProvider.notifier).state = device;
      print("CONNECTÉ à ${device.platformName} !");

      _connectionSubscription = device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          print("Perte de connexion");
          ref.read(isConnectedProvider.notifier).state = false;
          ref.read(connectedDeviceProvider.notifier).state = null;
        }
      });
    } catch (e) {
      print("Échec connexion: $e");
      ref.read(isConnectedProvider.notifier).state = false;

      try {
        await device.disconnect();
      } catch (_) {}
    }
  }

  Future<void> disconnect() async {
    final device = ref.read(connectedDeviceProvider);
    if (device != null) {
      await device.disconnect();
      await _connectionSubscription?.cancel();
      ref.read(isConnectedProvider.notifier).state = false;
      ref.read(connectedDeviceProvider.notifier).state = null;
      print("Déconnecté manuellement");
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
    final user = ref.read(usersProvider).asData?.value;
    if (device == null) {
      print("Pas d'appareil connecté");
      return;
    }

    try {
      print("Recherche du service et de la caractéristique...");

      List<BluetoothService> services = await device.discoverServices();

      BluetoothCharacteristic? targetChar;

      for (var service in services) {
        if (service.uuid.toString().toLowerCase() ==
            SERVICE_UUID.toLowerCase()) {
          for (var c in service.characteristics) {
            if (c.uuid.toString().toLowerCase() ==
                CHARACTERISTIC_UUID.toLowerCase()) {
              targetChar = c;
              break;
            }
          }
        }
      }

      if (targetChar != null) {
        print("Préparation de la commande JSON...");
        print("User badge ID: ${user?.badgeId}");
        DateTime now = DateTime.now();
        String formattedDate = DateFormat(
          'yyyy-MM-dd\'T\'HH:mm:00',
        ).format(now);

        Map<String, dynamic> command = {
          "action": "open",
          "badge_id": user?.badgeId,
          "timestamp": formattedDate,
        };

        String jsonString = jsonEncode(command);
        print("Envoi: $jsonString");

        List<int> bytes = utf8.encode(jsonString);

        await targetChar.write(bytes, withoutResponse: false);

        print("Commande envoyée avec succès !");
      } else {
        print("Caractéristique introuvable. Vérifie les UUIDs dans l'Arduino.");
        print("Attendu Service: $SERVICE_UUID");
        print("Attendu Char: $CHARACTERISTIC_UUID");

        print("Services trouvés:");
        for (var s in services) {
          print("- Service: ${s.uuid}");
          for (var c in s.characteristics) {
            print("  - Char: ${c.uuid}");
          }
        }
      }
    } catch (e) {
      print("Erreur lors de l'envoi: $e");
    }
  }
}
