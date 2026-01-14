class Proms {
  final String id;
  final String name;
  final String city;

  Proms({required this.id, required this.name, required this.city});

  factory Proms.fromMap(Map<String, dynamic> map) {
    return Proms(id: map['id'], name: map['name'], city: map['city']);
  }
}
