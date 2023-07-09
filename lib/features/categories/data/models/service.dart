import '../../domain/entities/service.dart';

class ServiceModel extends Service {
  const ServiceModel(
      {required int id,
      required String name,
      required String description,
      String? photo})
      : super(id: id, name: name, description: description, photo: photo);

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] as int,
        photo: json['photo'] as String?,
        name: json['name'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'photo': photo,
        'name': name,
        'description': description,
      };
}
