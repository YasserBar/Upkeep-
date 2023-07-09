import '../../domain/entities/city.dart';
import 'region.dart';

class CityModel extends City {
  const CityModel({
    required int id,
    required String name,
    required int countryId,
    required List<RegionModale> regions,
  }) : super(
          id: id,
          name: name,
          countryId: countryId,
          regions: regions,
        );

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['id'] as int,
        name: json['name'] as String,
        countryId: json['country_id'] as int,
        regions: (json['region'] as List<dynamic>)
            .map((e) => RegionModale.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country_id': countryId,
        'region': regions.map((e) => e.toJson()).toList(),
      };
}
