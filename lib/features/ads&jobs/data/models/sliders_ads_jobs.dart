import '../../domain/entities/sliders_ads_jobs.dart';

import 'city.dart';
import 'country.dart';
import 'region.dart';

class SlidersAdsJobsModel extends SlidersAdsJobs {
  const SlidersAdsJobsModel({
    required int id,
    required int foundationId,
    required String title,
    required String description,
    required String photo,
    required String foundationName,
    CountryModel? country,
    CityModel? city,
    RegionModel? region,
  }) : super(
            id: id,
            foundationId: foundationId,
            title: title,
            description: description,
            photo: photo,
            foundationName: foundationName);

  factory SlidersAdsJobsModel.fromJson(Map<String, dynamic> json) {
    return SlidersAdsJobsModel(
      id: json['id'] as int,
      foundationId: json['foundation_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
      foundationName: json['foundation_name'] as String,
      country: json['country'] == null
          ? null
          : CountryModel.fromJson(json['country'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : RegionModel.fromJson(json['region'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'foundation_id': foundationId,
        'title': title,
        'description': description,
        'photo': photo,
        'foundation_name': foundationName,
        'country': country?.toJson(),
        'city': city?.toJson(),
        'region': region?.toJson(),
      };
}
