import '../../domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({required int id, required String name})
      : super(id: id, name: name);

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
