import 'package:equatable/equatable.dart';

class FilterFoundations extends Equatable {
  final int? countryId;
  final int? cityId;
  final int? regionId;
  final int? subServiceId;

  const FilterFoundations({
    this.countryId,
    this.cityId,
    this.regionId,
    this.subServiceId,
  });

  @override
  List<Object?> get props {
    return [
      countryId,
      cityId,
      regionId,
      subServiceId,
    ];
  }
}
