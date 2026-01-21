import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:a4_iot/domain/usecases/reservations.dart';
import 'package:a4_iot/domain/entities/reservations.dart';
import 'package:a4_iot/data/datasources/local/reservations.dart';
import 'package:a4_iot/data/datasources/remote/reservations.dart';
import 'package:a4_iot/data/repositories/reservations_impl.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final courseRemoteProvider = Provider<ReservationsRemoteDatasource>((ref) {
  return ReservationsRemoteDatasource(ref.read(supabaseProvider));
});

final courseLocalProvider = Provider<ReservationsLocalDatasource>((ref) {
  return ReservationsLocalDatasource();
});

final courseRepositoryProvider = Provider<ReservationsRepositoryImpl>((ref) {
  return ReservationsRepositoryImpl(
    ref.read(courseRemoteProvider),
    ref.read(courseLocalProvider),
  );
});

final getReservationsProvider = Provider<GetReservations>((ref) {
  return GetReservations(ref.read(courseRepositoryProvider));
});

final getReservationsByIdProvider = Provider<GetReservationsById>((ref) {
  return GetReservationsById(ref.read(courseRepositoryProvider));
});

final getReservationsByIdsProvider = Provider<GetReservationsByIds>((ref) {
  return GetReservationsByIds(ref.read(courseRepositoryProvider));
});

final getReservationsFromUsersReservesByUserIdProvider =
    Provider<GetReservationsFromUsersReservesByUserId>((ref) {
      return GetReservationsFromUsersReservesByUserId(
        ref.read(courseRepositoryProvider),
      );
    });

final createReservationsProvider = Provider<CreateReservations>((ref) {
  return CreateReservations(ref.read(courseRepositoryProvider));
});

final updateReservationsProvider = Provider<UpdateReservations>((ref) {
  return UpdateReservations(ref.read(courseRepositoryProvider));
});

final deleteReservationsProvider = Provider<DeleteReservations>((ref) {
  return DeleteReservations(ref.read(courseRepositoryProvider));
});

final reservationsByIdProvider =
    FutureProvider.family<List<Reservations>, String>((
      ref,
      reservationsId,
    ) async {
      final getReservationsById = ref.read(getReservationsByIdProvider);
      return await getReservationsById(reservationsId);
    });

final reservationsByIdsProvider =
    FutureProvider.family<List<Reservations>, List<String>>((
      ref,
      reservationsIds,
    ) async {
      final getReservationsByIds = ref.read(getReservationsByIdsProvider);
      return await getReservationsByIds(reservationsIds);
    });

final reservationsFromUsersReservesByUserIdProvider =
    FutureProvider.family<List<Reservations>, String>((
      ref,
      reservationsIds,
    ) async {
      final getReservationsFromUsersReservesByUserId = ref.read(
        getReservationsFromUsersReservesByUserIdProvider,
      );
      return await getReservationsFromUsersReservesByUserId(reservationsIds);
    });
