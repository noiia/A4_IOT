import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/usecases/proms.dart';
import 'package:a4_iot/domain/entities/proms.dart';
import 'package:a4_iot/data/datasources/local/proms.dart';
import 'package:a4_iot/data/datasources/remote/proms.dart';
import 'package:a4_iot/data/repositories/proms_impl.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final courseRemoteProvider = Provider<PromsRemoteDatasource>((ref) {
  return PromsRemoteDatasource(ref.read(supabaseProvider));
});

final courseLocalProvider = Provider<PromsLocalDatasource>((ref) {
  return PromsLocalDatasource();
});

final courseRepositoryProvider = Provider<PromsRepositoryImpl>((ref) {
  return PromsRepositoryImpl(
    ref.read(courseRemoteProvider),
    ref.read(courseLocalProvider),
  );
});

final getPromsProvider = Provider<GetProms>((ref) {
  return GetProms(ref.read(courseRepositoryProvider));
});

final getPromsByIdProvider = Provider<GetPromsById>((ref) {
  return GetPromsById(ref.read(courseRepositoryProvider));
});

final createPromsProvider = Provider<CreateProms>((ref) {
  return CreateProms(ref.read(courseRepositoryProvider));
});

final updatePromsProvider = Provider<UpdateProms>((ref) {
  return UpdateProms(ref.read(courseRepositoryProvider));
});

final deletePromsProvider = Provider<DeleteProms>((ref) {
  return DeleteProms(ref.read(courseRepositoryProvider));
});

final promsByIdProvider = FutureProvider.family<Proms, String>((
  ref,
  promsId,
) async {
  final getPromsById = ref.read(getPromsByIdProvider);
  return await getPromsById(promsId);
});
