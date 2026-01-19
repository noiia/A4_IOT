import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/usecases/campus.dart';
import 'package:a4_iot/domain/entities/campus.dart';
import 'package:a4_iot/data/datasources/local/campus.dart';
import 'package:a4_iot/data/datasources/remote/campus.dart';
import 'package:a4_iot/data/repositories/campus_impl.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final courseRemoteProvider = Provider<CampusRemoteDatasource>((ref) {
  return CampusRemoteDatasource(ref.read(supabaseProvider));
});

final courseLocalProvider = Provider<CampusLocalDatasource>((ref) {
  return CampusLocalDatasource();
});

final courseRepositoryProvider = Provider<CampusRepositoryImpl>((ref) {
  return CampusRepositoryImpl(
    ref.read(courseRemoteProvider),
    ref.read(courseLocalProvider),
  );
});

final getCampusProvider = Provider<GetCampus>((ref) {
  return GetCampus(ref.read(courseRepositoryProvider));
});

final getCampusByIdProvider = Provider<GetCampusById>((ref) {
  return GetCampusById(ref.read(courseRepositoryProvider));
});

final createCampusProvider = Provider<CreateCampus>((ref) {
  return CreateCampus(ref.read(courseRepositoryProvider));
});

final updateCampusProvider = Provider<UpdateCampus>((ref) {
  return UpdateCampus(ref.read(courseRepositoryProvider));
});

final deleteCampusProvider = Provider<DeleteCampus>((ref) {
  return DeleteCampus(ref.read(courseRepositoryProvider));
});

final campusByIdProvider = FutureProvider.family<Campus, String>((
  ref,
  campusId,
) async {
  final getCampusById = ref.read(getCampusByIdProvider);
  return await getCampusById(campusId);
});
