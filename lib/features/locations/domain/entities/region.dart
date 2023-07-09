import 'package:equatable/equatable.dart';

class Region extends Equatable {
  final int id;
  final String name;
  final int countryId;
  final int cityId;

  const Region({
    required this.id,
    required this.name,
    required this.countryId,
    required this.cityId,
  });

  @override
  List<Object> get props => [id, name, countryId, cityId];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
      'city_id': cityId,
    };
  }
}
