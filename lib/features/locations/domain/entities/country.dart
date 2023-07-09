import 'package:equatable/equatable.dart';

import 'city.dart';

class Country extends Equatable {
  final int id;
  final String name;
  final List<City> cities;

  const Country({
    required this.id,
    required this.name,
    required this.cities,
  });

  @override
  List<Object?> get props => [id, name, cities];
}
