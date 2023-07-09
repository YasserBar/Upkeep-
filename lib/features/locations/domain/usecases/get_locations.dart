import 'package:dartz/dartz.dart';
import '../entities/country.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/locations_repo.dart';

class GetLocationsUsecase {
  final LocationsRepo repo;

  GetLocationsUsecase(this.repo);

  Future<Either<Failure, List<Country>>> call() async {
    return await repo.getLocations();
  }
}
