import '../../domain/entities/country.dart';
import 'city.dart';

class CountryModel extends Country {
  const CountryModel({
    required id,
    required name,
    required cities,
  }) : super(id: id, name: name, cities: cities);

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json['id'] as int,
        name: json['name'] as String,
        cities: (json['city'] as List<dynamic>)
            .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': cities.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [id, name, cities];
}
