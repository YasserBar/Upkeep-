import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/filter_foundations.dart';
import '../entities/foundation.dart';

abstract class FoundationsRepo {
  Future<Either<Failure, List<Foundation>>> getAllFoundationsForOwner(int page);
  Future<Either<Failure, List<Foundation>>> filterFoundations(
      FilterFoundations filterFoundation, int page);
}
