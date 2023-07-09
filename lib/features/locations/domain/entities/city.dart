import 'package:equatable/equatable.dart';

import 'region.dart';

class City extends Equatable {
  final int id;
  final String name;
  final int countryId;
  final List<Region> regions;

  const City({
    required this.id,
    required this.name,
    required this.countryId,
    required this.regions,
  });

  @override
  List<Object?> get props => [id, name, countryId, regions];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country_id': countryId,
        'region': regions.map((e) => e.toJson()).toList(),
      };
}
