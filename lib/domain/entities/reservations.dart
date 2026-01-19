class Reservations {
  final String id;
  final String usersReserves;
  final DateTime starts;
  final DateTime ends;
  final DateTime createdAt;

  Reservations({
    required this.id,
    required this.usersReserves,
    required this.starts,
    required this.ends,
    required this.createdAt,
  });
}
