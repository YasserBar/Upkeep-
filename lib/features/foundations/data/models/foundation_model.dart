import '../../domain/entities/foundation.dart';

class FoundationModel extends Foundation {
  const FoundationModel({
    required int id,
    int? active,
    required String name,
    required String photo,
    required String description,
  }) : super(
            id: id,
            active: active,
            name: name,
            photo: photo,
            description: description);

  factory FoundationModel.fromJson(Map<String, dynamic> json) {
    return FoundationModel(
      id: json['id'] as int,
      active: json['active'] as int?,
      name: json['name'] as String,
      photo: json['photo'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'name': name,
      'photo': photo,
      'description': description,
    };
  }
}
