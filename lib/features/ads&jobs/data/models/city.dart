import '../../domain/entities/city.dart';

class CityModel extends City {
  const CityModel({required int id, required String name})
      : super(id: id, name: name);

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
