import '../../domain/entities/region.dart';

class RegionModel extends Region {
  const RegionModel({required int id, required String name})
      : super(id: id, name: name);

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
