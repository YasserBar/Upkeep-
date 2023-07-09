import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/service.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<Service>>> getAllServiceInSystem(int page);

  Future<Either<Failure, List<Service>>> getAllSubServiceInSystem(
     int serviceId, int page);
}
