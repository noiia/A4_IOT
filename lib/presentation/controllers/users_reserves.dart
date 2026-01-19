import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/usecases/users_reserves.dart';
import 'package:a4_iot/domain/entities/users_reserves.dart';
import 'package:a4_iot/data/datasources/local/users_reserves.dart';
import 'package:a4_iot/data/datasources/remote/users_reserves.dart';
import 'package:a4_iot/data/repositories/users_reserves_impl.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final courseRemoteProvider = Provider<UsersReservesRemoteDatasource>((ref) {
  return UsersReservesRemoteDatasource(ref.read(supabaseProvider));
});

final courseLocalProvider = Provider<UsersReservesLocalDatasource>((ref) {
  return UsersReservesLocalDatasource();
});

final courseRepositoryProvider = Provider<UsersReservesRepositoryImpl>((ref) {
  return UsersReservesRepositoryImpl(
    ref.read(courseRemoteProvider),
    ref.read(courseLocalProvider),
  );
});

final getUsersReservesProvider = Provider<GetUsersReserves>((ref) {
  return GetUsersReserves(ref.read(courseRepositoryProvider));
});

final getUsersReservesByIdProvider = Provider<GetUsersReservesById>((ref) {
  return GetUsersReservesById(ref.read(courseRepositoryProvider));
});

final getUsersReservesByUsersIdProvider = Provider<GetUsersReservesByUsersId>((
  ref,
) {
  return GetUsersReservesByUsersId(ref.read(courseRepositoryProvider));
});

final getUsersReservesByUserIdProvider =
    Provider<GetUsersReservesByReservationsId>((ref) {
      return GetUsersReservesByReservationsId(
        ref.read(courseRepositoryProvider),
      );
    });

final createUsersReservesProvider = Provider<CreateUsersReserves>((ref) {
  return CreateUsersReserves(ref.read(courseRepositoryProvider));
});

final updateUsersReservesProvider = Provider<UpdateUsersReserves>((ref) {
  return UpdateUsersReserves(ref.read(courseRepositoryProvider));
});

final deleteUsersReservesProvider = Provider<DeleteUsersReserves>((ref) {
  return DeleteUsersReserves(ref.read(courseRepositoryProvider));
});

final usersReservesByIdProvider =
    FutureProvider.family<List<UsersReserves>, String>((
      ref,
      usersReservesId,
    ) async {
      final getUsersReservesById = ref.read(getUsersReservesByIdProvider);
      return await getUsersReservesById(usersReservesId);
    });
