import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:a4_iot/domain/usecases/proms.dart';
import 'package:a4_iot/domain/entities/proms.dart';
import 'package:a4_iot/data/datasources/local/proms.dart';
import 'package:a4_iot/data/datasources/remote/proms.dart';
import 'package:a4_iot/data/repositories/proms_impl.dart';

// --- 1. INFRASTRUCTURE ---

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final promsRemoteProvider = Provider<PromsRemoteDatasource>((ref) {
  return PromsRemoteDatasource(ref.read(supabaseProvider));
});

final promsLocalProvider = Provider<PromsLocalDatasource>((ref) {
  return PromsLocalDatasource();
});

final promsRepositoryProvider = Provider<PromsRepositoryImpl>((ref) {
  return PromsRepositoryImpl(
    ref.read(promsRemoteProvider),
    ref.read(promsLocalProvider),
  );
});

// --- 2. USE CASES ---

final getPromsProvider = Provider<GetProms>((ref) {
  return GetProms(ref.read(promsRepositoryProvider));
});

final getPromsByIdProvider = Provider<GetPromsById>((ref) {
  return GetPromsById(ref.read(promsRepositoryProvider));
});

final createPromsProvider = Provider<CreateProms>((ref) {
  return CreateProms(ref.read(promsRepositoryProvider));
});

final updatePromsProvider = Provider<UpdateProms>((ref) {
  return UpdateProms(ref.read(promsRepositoryProvider));
});

final deletePromsProvider = Provider<DeleteProms>((ref) {
  return DeleteProms(ref.read(promsRepositoryProvider));
});

// --- 3. DATA PROVIDERS (Lecture) ---

/// Récupère toutes les promotions
final allPromsProvider = FutureProvider<List<Proms>>((ref) async {
  final getProms = ref.read(getPromsProvider);
  return await getProms("unused_id"); // Adaptez si votre call() prend un ID
});

/// Récupère une promo par ID
final promsByIdProvider = FutureProvider.family<Proms, String>((ref, id) async {
  final getById = ref.read(getPromsByIdProvider);
  return await getById(id);
});

// --- 4. CONTROLLER (Écriture - Version Moderne Notifier) ---

final promsControllerProvider = AsyncNotifierProvider<PromsController, void>(
  PromsController.new,
);

class PromsController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // Initialement rien à faire
    return;
  }

  Future<void> createProms(String name, String campusId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final create = ref.read(createPromsProvider);
      await create(name: name, campusId: campusId);
      ref.invalidate(allPromsProvider);
    });
  }

  Future<void> updateProms(String id, {String? name, String? campusId}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final update = ref.read(updatePromsProvider);
      if (name != null && campusId != null) {
        await update(id: id, name: name, campusId: campusId);
      }
      ref.invalidate(allPromsProvider);
      ref.invalidate(promsByIdProvider(id));
    });
  }

  Future<void> deleteProms(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final delete = ref.read(deletePromsProvider);
      await delete(id);
      ref.invalidate(allPromsProvider);
    });
  }
}
