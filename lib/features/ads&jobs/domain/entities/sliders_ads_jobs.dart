import 'package:equatable/equatable.dart';

import 'city.dart';
import 'country.dart';
import 'region.dart';

class SlidersAdsJobs extends Equatable {
  final int id;
  final int foundationId;
  final String title;
  final String description;
  final String photo;
  final String foundationName;
  final Country? country;
  final City? city;
  final Region? region;

  const SlidersAdsJobs({
    required this.id,
    required this.foundationId,
    required this.title,
    required this.description,
    required this.photo,
    required this.foundationName,
    this.country,
    this.city,
    this.region,
  });

  @override
  List<Object?> get props {
    return [
      id,
      foundationId,
      title,
      description,
      photo,
      foundationName,
      country,
      city,
      region,
    ];
  }
}
