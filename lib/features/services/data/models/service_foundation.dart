// ignore_for_file: non_constant_identifier_names

import '../../domain/entities/service_foundation.dart';

class ServiceFoundationModel extends ServiceFoundation {
  const ServiceFoundationModel({
    required int id,
    required int foundations_id,
    required String foundations_name,
    required String foundations_description,
    required String photo,
    required String services_description,
    required int service_cost,
    required String duration_work,
    required int service_id,
    required String service_name,
    required String countries_name,
    required String cities_name,
    required String regions_name,
  }) : super(
          id: id,
          photo: photo,
          cities_name: cities_name,
          countries_name: countries_name,
          foundations_description: foundations_description,
          duration_work: duration_work,
          foundations_id: foundations_id,
          foundations_name: foundations_name,
          regions_name: regions_name,
          service_cost: service_cost,
          service_id: service_id,
          service_name: service_name,
          services_description: services_description,
        );

  factory ServiceFoundationModel.fromJson(Map<String, dynamic> json) {
    return ServiceFoundationModel(
      id: json['id'] as int,
      photo: json['photo'] as String,
      cities_name: json['cities_name'] as String,
      countries_name: json['countries_name'] as String,
      foundations_description: json['foundations_description'] as String,
      foundations_id: json['foundations_id'] as int,
      foundations_name: json['foundations_name'] as String,
      regions_name: json['regions_name'] as String,
      service_cost: json['service_cost'] as int,
      service_id: json['service_id'] as int,
      duration_work: json['duration_work'] as String,
      services_description: json['services_description'] as String,
      service_name: json['service_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'photo': photo,
        'cities_name': cities_name,
        'countries_name': countries_name,
        'foundations_description': foundations_description,
        'foundations_id': foundations_id, 
        'foundations_name': foundations_name, 
        'regions_name': regions_name, 
        'service_cost': service_cost, 
        'service_id': service_id, 
        'duration_work': duration_work, 
        'services_description': services_description, 
        'service_name': service_name,
      };
}
