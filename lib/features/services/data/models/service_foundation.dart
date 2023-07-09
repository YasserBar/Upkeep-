import '../../domain/entities/service_foundation.dart';

class ServiceFoundationModel extends ServiceFoundation {
  const ServiceFoundationModel({
    required int id,
    required String photo,
    required String name,
    required String description,
    required int serviceCost,
    required String durationWork,
  }) : super(
            id: id,
            photo: photo,
            name: name,
            description: description,
            serviceCost: serviceCost,
            durationWork: durationWork);

  factory ServiceFoundationModel.fromJson(Map<String, dynamic> json) {
    return ServiceFoundationModel(
      id: json['id'] as int,
      photo: json['photo'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      serviceCost: json['service_cost'] as int,
      durationWork: json['duration_work'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'photo': photo,
        'name': name,
        'description': description,
        'service_cost': serviceCost,
        'duration_work': durationWork,
      };
}
