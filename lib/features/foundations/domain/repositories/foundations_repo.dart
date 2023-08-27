import 'package:dartz/dartz.dart';
import 'package:upkeep_plus/features/services/domain/entities/service_foundation.dart';

import '../../../../core/errors/failures.dart';
import '../entities/filter_foundations.dart';
import '../entities/foundation.dart';

abstract class FoundationsRepo {
  Future<Either<Failure, List<Foundation>>> getAllFoundationsForOwner(int page);
  Future<Either<Failure, List<ServiceFoundation>>> filterFoundations(
      FilterFoundations filterFoundation, int page);
  Future<Either<Failure, List<Foundation>>> filterFoundationsInSystem(
      FilterFoundations filterFoundation, int page);
  Future<Either<Failure, Unit>> stopFoundation(int id);
}
