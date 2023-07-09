import '../../domain/entities/region.dart';

class RegionModale extends Region {
  const RegionModale({
    required int id,
    required String name,
    required int countryId,
    required int cityId,
  }) : super(
          id: id,
          name: name,
          countryId: countryId,
          cityId: cityId,
        );

  factory RegionModale.fromJson(Map<String, dynamic> json) {
    return RegionModale(
      id: json['id'] as int,
      name: json['name'] as String,
      countryId: json['country_id'] as int,
      cityId: json['city_id'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
      'city_id': cityId,
    };
  }
}
