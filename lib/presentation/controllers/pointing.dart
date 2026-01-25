import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:a4_iot/domain/usecases/pointing.dart';
import 'package:a4_iot/domain/entities/pointing.dart';
import 'package:a4_iot/data/datasources/local/pointing.dart';
import 'package:a4_iot/data/datasources/remote/pointing.dart';
import 'package:a4_iot/data/repositories/pointing_impl.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final pointingRemoteProvider = Provider<PointingRemoteDatasource>((ref) {
  return PointingRemoteDatasource(ref.read(supabaseProvider));
});

final pointingLocalProvider = Provider<PointingLocalDatasource>((ref) {
  return PointingLocalDatasource();
});

final pointingRepositoryProvider = Provider<PointingRepositoryImpl>((ref) {
  return PointingRepositoryImpl(
    ref.read(pointingRemoteProvider),
    ref.read(pointingLocalProvider),
  );
});

final getPointingProvider = Provider<GetPointing>((ref) {
  return GetPointing(ref.read(pointingRepositoryProvider));
});

final getPointingByIdProvider = Provider<GetPointingById>((ref) {
  return GetPointingById(ref.read(pointingRepositoryProvider));
});

final getLastPointingByUserBadgeIdProvider =
    Provider<GetLastPointingByUserBadgeId>((ref) {
      return GetLastPointingByUserBadgeId(ref.read(pointingRepositoryProvider));
    });

final getPointingsByUserBadgeIdProvider = Provider<GetPointingsByUserBadgeId>((
  ref,
) {
  return GetPointingsByUserBadgeId(ref.read(pointingRepositoryProvider));
});

final createPointingProvider = Provider<CreatePointing>((ref) {
  return CreatePointing(ref.read(pointingRepositoryProvider));
});

final allPointingProvider = FutureProvider<List<Pointing>>((ref) async {
  final getPointing = ref.read(getPointingProvider);
  return await getPointing();
});

final pointingByIdProvider = FutureProvider.family<Pointing, String>((
  ref,
  id,
) async {
  final getById = ref.read(getPointingByIdProvider);
  return await getById(id);
});

final lastPointingByIdProvider = FutureProvider.family<Pointing, String>((
  ref,
  id,
) async {
  final getLastPointingByUserBadgeId = ref.read(
    getLastPointingByUserBadgeIdProvider,
  );
  return await getLastPointingByUserBadgeId(id);
});

final pointingsByUserBadgeIdProvider =
    FutureProvider.family<List<Pointing>, String>((ref, pointingIds) async {
      final getPointingsByUserBadgeId = ref.read(
        getPointingsByUserBadgeIdProvider,
      );
      return await getPointingsByUserBadgeId(pointingIds);
    });
