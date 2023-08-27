// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class ServiceFoundation extends Equatable {
  final int id;
  final int foundations_id;
  final String foundations_name;
  final String foundations_description;
  final String photo;
  final String services_description;
  final int service_cost;
  final String duration_work;
  final int service_id;
  final String service_name;
  final String countries_name;
  final String cities_name;
  final String regions_name;

  const ServiceFoundation({
    required this.id,
    required this.photo,
    required this.cities_name,
    required this.countries_name,
    required this.foundations_description,
    required this.duration_work,
    required this.foundations_id,
    required this.foundations_name,
    required this.regions_name,
    required this.service_cost,
    required this.service_id,
    required this.service_name,
    required this.services_description,
  });
  @override
  List<Object?> get props {
    return [
      id,
      photo,
      photo,
      cities_name,
      countries_name,
      foundations_description,
      duration_work,
      foundations_id,
      foundations_name,
      regions_name,
      service_cost,
      service_id,
      service_name,
      services_description,
      photo,
      cities_name,
      countries_name,
      foundations_description,
      duration_work,
      foundations_id,
      foundations_name,
      regions_name,
      service_cost,
      service_id,
      service_name,
      services_description,
      photo,
      cities_name,
      countries_name,
      foundations_description,
      duration_work,
      foundations_id,
      foundations_name,
      regions_name,
      service_cost,
      service_id,
      service_name,
      services_description,
    ];
  }
}
