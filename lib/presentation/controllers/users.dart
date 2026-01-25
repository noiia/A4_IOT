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

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

final currentUserProvider = Provider<User?>((ref) {
  final auth = ref.watch(authStateProvider).value;
  return auth?.session?.user;
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

final getHomeUserByAuthUserIdProvider = Provider<GetHomeUsersByAuthUserId>((
  ref,
) {
  return GetHomeUsersByAuthUserId(ref.read(userRepositoryProvider));
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
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    throw Exception("User not authenticated");
  }

  final getUsersByAuthUserId = ref.read(getUsersByAuthUserIdProvider);
  return getUsersByAuthUserId(user.id);
});

final homeUsersProvider = FutureProvider<HomeUsers>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    throw Exception("User not authenticated");
  }

  final getHomeUsersByAuthId = ref.read(getHomeUserByAuthUserIdProvider);
  return getHomeUsersByAuthId(user.id);
});

final allUsersProvider = FutureProvider<List<Users>>((ref) async {
  final getUsers = ref.read(getUsersProvider);
  // Adaptez l'appel si votre call() demande un paramètre
  return await getUsers("unused");
});

final studentsByPromsIdProvider = FutureProvider.family<List<Users>, String>((
  ref,
  promsId,
) async {
  final allUsers = await ref.watch(allUsersProvider.future);

  for (var u in allUsers) {
    // On affiche les 3 premiers pour pas polluer
    if (allUsers.indexOf(u) < 3) {}
  }
  return allUsers
      .where((user) => user.promsId.trim() == promsId.trim())
      .toList();
});
