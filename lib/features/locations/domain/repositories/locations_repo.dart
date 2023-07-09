import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/country.dart';

abstract class LocationsRepo {
  Future<Either<Failure, List<Country>>> getLocations();
}
