import '../../domain/entities/filter_foundations.dart';

class FilterFoundationsModel extends FilterFoundations {
  const FilterFoundationsModel({
    final int? countryId,
    final int? cityId,
    final int? regionId,
    final int? subServiceId,
  }) : super(
          cityId: cityId,
          countryId: countryId,
          regionId: regionId,
          subServiceId: subServiceId,
        );

  factory FilterFoundationsModel.fromJson(Map<String, dynamic> json) {
    return FilterFoundationsModel(
      countryId: json['countries_id'] as int?,
      cityId: json['cities_id'] as int?,
      regionId: json['regions_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countries_id': countryId,
      'cities_id': cityId,
      'regions_id': regionId,
      'sub_service_id': subServiceId,
    };
  }
}
