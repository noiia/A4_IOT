import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/usecases/users.dart';
import 'package:a4_iot/domain/entities/users.dart';
import 'package:a4_iot/data/datasources/local/users.dart';
import 'package:a4_iot/data/datasources/remote/users.dart';
import 'package:a4_iot/data/repositories/users_impl.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final userRemoteProvider = Provider<UsersRemoteDatasource>((ref) {
  return UsersRemoteDatasource(ref.read(supabaseProvider));
});

final userLocalProvider = Provider<UsersLocalDatasource>((ref) {
  return UsersLocalDatasource();
});

final userRepositoryProvider = Provider<UsersRepositoryImpl>((ref) {
  return UsersRepositoryImpl(
    ref.read(userRemoteProvider),
    ref.read(userLocalProvider),
  );
});

final getUsersProvider = Provider<GetUsers>((ref) {
  return GetUsers(ref.read(userRepositoryProvider));
});

final getUsersByAuthUserIdProvider = Provider<GetUsersByAuthUserId>((ref) {
  return GetUsersByAuthUserId(ref.read(userRepositoryProvider));
});

final getUsersByBadgeIdrovider = Provider<GetUsersByBadgeId>((ref) {
  return GetUsersByBadgeId(ref.read(userRepositoryProvider));
});

final createUsersProvider = Provider<CreateUsers>((ref) {
  return CreateUsers(ref.read(userRepositoryProvider));
});

final updateUsersProvider = Provider<UpdateUsers>((ref) {
  return UpdateUsers(ref.read(userRepositoryProvider));
});

final deleteUsersProvider = Provider<DeleteUsers>((ref) {
  return DeleteUsers(ref.read(userRepositoryProvider));
});

final usersProvider = FutureProvider<Users>((ref) async {
  final userId = Supabase.instance.client.auth.currentUser!.id;
  final getUsersByAuthUserId = ref.read(getUsersByAuthUserIdProvider);

  return getUsersByAuthUserId(userId);
});
